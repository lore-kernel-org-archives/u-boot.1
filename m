Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BEC606A335
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nhZ2NkZL;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CLeCR6Uo
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CF72605A7;
	Wed,  4 Nov 2026 09:28:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3VDNEw8d2J5B; Wed,  4 Nov 2026 09:28:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 35A42605D9
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793784490;
	b=FZu2oCouzNSJofSBw0LoyNtglF5aTRMWZVv95wyNYyvi8Hlc7TUiXVZvrUkWN+gLoFGa
	 kpUVJkRjuGdh7yUID5o01e0WeUxIs22+rVyNSB2EPllT7VNhgNNQ7HEUUBvScJdX6Cpwn
	 Hm1tI3pD9zJxtRJ7PiK0G9Sfcp80XsdVqPBcQ8Ayi5PNsKBwLjKo/0fcPUnMtywLu0tHD
	 vuohEaetHkWSQTEaJ39jKQNBg4/ZrcAGouT70HtZSl5H+eDGeI+vpovRTZuD/Kwh9jdAh
	 5/oqy3YnhjhUd6EOsp5f/vfebLw2uZds2vXQZePnBzW3b8/FNOvxaqVS7OOhE9mbLRA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793784490;
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
	bh=mzJVN66VifaXDIJdY+qQue4meiSJUlZM3UUCoOIsS0w=;
	b=EtWk/uaOVQ7ll1nSy4gSX1+zAg6fZxlWlj+tBUonVu1nIiBALoI2WxNY9V3wdWGDbCQd
	 uwcnQOIja6X53mcq61xfINY95RO6ka/ch+lMgp/iIf90H29yuu8FF3xj5Kr2i5gyXpKjA
	 wGlaqKH7XgEJPlbTEDYB8eH1h/Dmud5PN90iKjgRlALsPcBgR0SD1fT2YnlkWnQ8Kd5Q+
	 fAERJMnLP0X42d4bGXAyefV2Paq0ZvAnaedqfk5VkDIZxh8BHvWyQb/JcjWL6QtZ6JK+p
	 B2TwqHYRbniZ7DDUJPAetF6RxA2L2XcNIfcEA9G6kUADo2BskFbJG8QHkYqGpy+JkWw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793784490;
	bh=mzJVN66VifaXDIJdY+qQue4meiSJUlZM3UUCoOIsS0w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nhZ2NkZLmgZh8vg7ZVIysBmpm+H8bqensCUy8JKYASCsO8L+7OPH6iP7dD/mTa4XG
	 JAZ8HzWLxSEEogqxnHRO02Si5tjQbfLkcIXuvGveRAMAavChfP2J3m6hDq6lvW2DCe
	 wa3142EDpHIzwHPQJRs6xzqL6dxdPpvlYm6+YQuF6Ih16JU6T47gdXO78fArzrYtfv
	 x+g/0wgyHda6EcdwoEUpNehGkap9qpYEx1QNQwoY2/eFoYL6rAFyfpG+P+kMpCX1du
	 VVcSgQFfJPRj6PDBIQ3+9SoYG13ZS8i7Ehi8rBXwH5KRGtTosjxXAP8X6xnEOBV+ba
	 XzUN7XZrFNqhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35A42605D9;
	Wed,  4 Nov 2026 09:28:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B8E4411
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:28:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D26E402B0
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:28:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8zT0yLNarlfu for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:28:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AE0C54004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c005::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793784487;
 b=IGE7aEho2PEnv0hyYOpdV1VUHAgjzNF8FcFrxtp7/9d1jsxT33o353dsmUd5D2qKXIja
 EcyRMa50zZebpQJHsNFbXpgNRuLydsu5Nq9jRhaTMM5RuqC6XcQb16Tp7jaP2KZq8sauu
 NKisPndFELOHpjKspEfy0ySOBrQv/5MaaBSYq69on3/bP9XdjiGQqu2vSCnVO2H9rqTNK
 lllBy87iJXuL+cT1AqBKUlIEqBNJDZ5LZNVrpnLRfC26pQbud7dhOCC3zafYM7YyzamDQ
 cPLowAUGN+uDhtvb9MnbCDMhabMAaxklmycT+L7pICHsOh4f1bSGNK/5g3uhbvB4YjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793784487;
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
 bh=mzJVN66VifaXDIJdY+qQue4meiSJUlZM3UUCoOIsS0w=;
 b=WLU9Kkuh/1N24rA4nT3/Z3tGOOl1RkyiV0T+xVd4kpvU91mFhinvZ375rtcY+rszBTXr
 O5ijIWmrSD5CjOcVfXJ9izaFVP49SmpEz/WS9hRVBXfBIwOl71HfX+mRwwcFmPiPw6d0d
 5kE3M+yUaYh+AlDQzZG6m8WKS2Huh87N2zs+uM9VdlxTMO6JmoqEUX1c25dkGSe/98txM
 FR+VUUh7y8ZdO0VgeC7mKvloV5hW+l7UGQLd0//nz7XGn4V0+4YsdihLVFwbNQlIACn5d
 jAoKNw3HkoecsJC90zxYpPFkfBaNzTMe/1OfHrrfviMUVaJ7/SM+OdXUFtsKfgcA+lA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=CLeCR6Uo; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c005::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c005::5;
 helo=co1pr03cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=CLeCR6Uo
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AE0C54004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:28:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dai4jI3Nani3EaDDnDOhvG+gaz/FkBoNMzjS4g6MfEJ5108K+bQZkMh2t6UbeVmJ/i8Je+5bMOopvt71GaBi2b8ZYJD7k15iXdCDS4fkSqbeqvVVHlqUjhhfXHraUWI6r7//inhlZreYB7KAMArKxFWTcY9d1ktUZzt0VuSPVCu3dphgayCbNU57fa1hGH2sDNedXyJn16oYzSjOi/EQuM6TlY3oVynIr/F3cor72gCt29E4CDug35kG5dmZtN589w2/SJ5C8uRZSYY2/0OtVuvqCFvIUNwKxeI+cjyStcmAG5QN7SbluFUk807E8eq/C7y2H7gnKNuttFZqzoQ0Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzJVN66VifaXDIJdY+qQue4meiSJUlZM3UUCoOIsS0w=;
 b=jvCyphq4NVmYqzRLZ8I+txa1zVIfK6TYwCMHpo+N4K7XpQP5nYdb/bmrxtOcHfh15W7NsZx6BT9CyqTaK8neKni6SuvwXsnYY7fW7xE+EaHmQU1jFD2cG/ioXjvpZPk9234knERHTHF9UCwJMaEDGbJyLs3W6gd03gs3K+SEYbG1n/GsRLRmy8IrLfyzmpEZ9eGWl5zZzIGNvrGsIxBx/D/2sk6WcHg2cC+dw02lrFVem3c3TkMYf7AhPS66d46840xcmd5u1OwsRJPkwZYVjP6+OZdbSmhCvLr/8azF1J+mgI7Ha/RKv6Kc3DshlX4Fso8rehulrlakGS7qE3QYnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzJVN66VifaXDIJdY+qQue4meiSJUlZM3UUCoOIsS0w=;
 b=CLeCR6UotIDwR4IYQFTJERb94BXbVIxFyHXzBdQLvUSpLLmEQQWwTZ+InHt+5pXMQx/wXSy2PkXe67LLuB5E4Snc7cGRdqkXJqgNs+jDWUCC0KK8FZCx0+7M57MEGHtG6ItYxJw3isiJxH1BSHjaAhQ0k16wejl5GbfnTaUvO6E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 09:28:03 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 09:28:03 +0000
Message-ID: <0b8ecd48-77b8-4794-a1eb-c4a680006708@amd.com>
Date: Wed, 4 Nov 2026 10:27:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] net: zynq_gem: plug resource leaks in .probe error
 path
To: Graeme Smecher <gsmecher@t0.technology>, u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
References: <20261103-zynq-gem-remove-leak-v3-0-2f02ec0023f9@t0.technology>
 <20261103-zynq-gem-remove-leak-v3-2-2f02ec0023f9@t0.technology>
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
In-Reply-To: <20261103-zynq-gem-remove-leak-v3-2-2f02ec0023f9@t0.technology>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::10) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SA0PR12MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d887bd-0021-4035-6f41-08df3a55ed14
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|18002099003|22082099003|11063799006|4143699003|261102123227099003|56012099006|261021121427099003|261022105027099003|261026140227099003|261028144727099003|261009223027099003|260925021311599003|261021123027099003|260925022911599003|260925021911599003;
X-Microsoft-Antispam-Message-Info: JaOHT/ddKT0/VYUMjHIZ5f2nRt5mwDWZ5j2hJBoCPEPJ6WkefNs5r8qEBzh3xvcr1XAhjQUouWCYRSWsj7Q/kG0+ImzZkS5KbZKav1FKmxBJw6xBwapTrP9UOcG+NQ2Ca5O5HF5dynsGce1GCsBfDMwlFotlJOzC7bk1saPKew+YnlmJdTJZTXivgLro6XmWbFm0cgemEDj3d1Ic1OlXN8AUx7WdVoNld2zX0RhqxPpD5U/h7hYDSswPCyJ4sF125mcEZkEIFHEOjUgwEdOB02J6/3nLTCgQi5ja+o1XUJ82PMdY2W783EE18UHxkyR7mug8zalmwQednEMAEy823nSnim1ABu76EI0SuswrPymb7aVFt44WmPYXG/8opQULbw6u7B9+Flzd0L5SvV6/JK98HTLeiE+7mvWtj/zyWjAevfGqo2hUH0RmBLURnnRNrr717ouSUVAaRJiwz6/XZZQEzQxuFSz2s1Y2obuU3OjqfPLAODWqRCY1yQMScSmMGlz223epjCzxZw8x5C9RC3/LHvcD4ml0UXSPCg+5pUvl0RvAMjCfiIBEGEZpxWrwi1d7cqA0nlbz4ENI/2or8jn4NX7r7ZKw3xfAaK7YeXLCjV6VywrDpiD3XqpSvVt33ArzZ5ctr0rp7NCl2AEiZpBs9f8WZj1/u63D2ts1FNY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(261102123227099003)(56012099006)(261021121427099003)(261022105027099003)(261026140227099003)(261028144727099003)(261009223027099003)(260925021311599003)(261021123027099003)(260925022911599003)(260925021911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlFyQWhTa1ZtS0JjdHdaZERPUGw5NExPelRrLzRkM3o4YUpTM1ZzemRQRXRu?=
 =?utf-8?B?b2ZwSkZGeHpka1NSMk1HajNmeUFKb08yWHZucVhacDdsNUJNUmtJMTEyV3cw?=
 =?utf-8?B?RUV1bjNJdUFzMkQwYkZEUjhWVGRrZXp2S21jYWNSNi9Hb2lCK2JSQ1RZMmdF?=
 =?utf-8?B?cUtrd0FvaTdGMTJFcXhFWCs5TEg1d3JjcVVNdlB5NTZqb3ozYkpEd3E4T0dl?=
 =?utf-8?B?dUNoMDFEdjlwbEJjYm1iTlRHWjlNRlpwVEc3WGU5KzRwbVFMNm9LZ3RBb0tU?=
 =?utf-8?B?NmlPOUtwVUlkOTFlM25UNjY5a3ZMVWc1NUNEVzI1Q3ZYTHJXTzF1cVZYZ0hU?=
 =?utf-8?B?Z1BPS1R2L1J6RVN2d1JRb0pzUVJZaXhrSEExQ1VTRy9zMzJRWDFlbnNLelFq?=
 =?utf-8?B?ejVPL2dPUHhjdnlwb2VKa0VjbG1aa0NhZ3pITzVYdm1CVGVJak5Ka1JDSjgy?=
 =?utf-8?B?K2xjMnZ3TW1UK3YzTEhPOGtoTXR4WmtwUHRLVWtOaVg1K2ZhbkZWejdzTVVo?=
 =?utf-8?B?M3FpemtmbHZuYWd4eW1BOXFyMnJ4SDJlSUExdVFiTlkxUWtqTVhVZVd2SklL?=
 =?utf-8?B?bU16RytxODlzS3ZkdjR2Nlg3c1BPWDZSbU1BeDc5SG5uQUh0L3VMVWRMbFJJ?=
 =?utf-8?B?TWU1R0N0bGJOd3ZVRGNhQXFUbTdPdk5yY3cweXk0OHZGY25HenBaWWdhOTMx?=
 =?utf-8?B?UjF4SVZrZTlMMTV4bEhWZ3pGL3ZjNVhYN1pUQ25PL1UyQmk3Y0ZsaEtDU3pI?=
 =?utf-8?B?bUkyUkhMdWgvNzRGTzR5UldTbDZCOVByYlNjdkVPV2RPVmZ0TWNCc1JoYlZ5?=
 =?utf-8?B?dTdKbWdtaEpEKzVYdk5hVE9Ob1lWMEhqeEMxdkdxZmQwLzBpekMzY2JtaWg4?=
 =?utf-8?B?WnZlaHZnSDF0djNIaHplZGlCUjNTNFlFR2tiN1kwSldaTGlvYmxiOThsRWRi?=
 =?utf-8?B?V2Rkck9reUgya2pJNGJzVzJkajZnNVpMcnQ2YTJwbUZNVC9EKzRTZnQ0NDQz?=
 =?utf-8?B?MzFpdnhvYnZWUE9iRFM3UmRQWElyalNwRDdpOUw2UU9DNTc2SGFDdFp0eWpY?=
 =?utf-8?B?TlgxaHVrbUZ6K0dJQTE1alBjVDhDb201NGVyY2FXaXRrYmtyQVVTZ2l3dElU?=
 =?utf-8?B?WU5FRUhoVE5kbzRPOTZRZWlteG9EY2hYOHFHaGFKMlpHRi8ydVZMZVdDaE1i?=
 =?utf-8?B?TnBtelY5aGsrbDQ5V0hOemVGcFcrSmQ4QjJlbGRpbnowTDVzWGY2ZVVITkE4?=
 =?utf-8?B?U3lHaFZSZkNoK0JGVFo4SDRoelJwdFJVcFEyR0lQRTM2TVhLVlhMK0ZUREho?=
 =?utf-8?B?UFJRcElSeUJvdlg3VHRMNHNSQnkvWlg5UjNZczRQVXRnTyttV296NXh5SWFD?=
 =?utf-8?B?amxCMEVqWHBsQVE5YUhDQVgwRis0TVUzRVZRMHhUT3J6V3daYjg1Qm9TUktx?=
 =?utf-8?B?c2hZZEVvR01NcVVqVS9HejRTMzhESDJxY09ZWmE1VnY3UHVZeTh5RStXcSth?=
 =?utf-8?B?Y1FRRWdHQVViK3RLTHBqV0hUM1FhWmtTbWE2QU8xVDhZSzkxNFc1KzFLOHFX?=
 =?utf-8?B?NEZ4Y21RNStOVER5OXg0K3RRb0FGdVR5ZkpDRXRSb2NVRzJPVHBPQXF2OVd0?=
 =?utf-8?B?RHJpSVRLWmNhOFNYNnVzcVAxcmdnZjhBSjJWR1N3OUxwaHczQ3EvQ1FMdDVO?=
 =?utf-8?B?cXFYSVBlM0hsak1nL1NmbjNmM2JLTVlUNXpQWlRNZ0htanJFNEx2dTFReUtJ?=
 =?utf-8?B?aTg5eVNqMkM5L1R1aHA3MHlRUzBqekQyOWZZUktTMzNFY3J6dzFsczJMa09R?=
 =?utf-8?B?b2RZdTlEMmZ6eVA1Q01Vd0ZiZis2TkZKL3Z3bjlsckVCTk5vZitTN1Ridjhj?=
 =?utf-8?B?VEo0QzRzZGRNMUc0cFExbmFVNVhUOWRDQlZubDhncHRhMnBqSVE1OHd2dmpS?=
 =?utf-8?B?MVlXdVdhY3ZMeVZReE10ZEQ1cGxmOGFYU2VkM3FSWDdjOXZwcXMyRllzL2FZ?=
 =?utf-8?B?VU91NDBGR3c3Ry9XWmpPckJ5MldkNjVyZFR4OWVVR1JQYXZXbnlobkRnVzR1?=
 =?utf-8?B?aG1tMWpOS092UTVKSk94bDJ0R1JvRkFITC8yTXZjdEJnSjNWVlpWWC94YWNM?=
 =?utf-8?B?TC9Kd2J6Q3Z1ekxPa1NCb0l6aktZS0hnaTl1VlRqUjZzRysyN29icGhielRN?=
 =?utf-8?B?a0dRNCtqSXpLNVNOV0tCM29ML0pRWktUaVVnZ3B3YmNjOEtBblptSjdFV2xz?=
 =?utf-8?B?aHc3SWRORGRVWU94S0RaT0I3N05McE5oV3pBRVlSeUxzN2s4enJvelJJcGVs?=
 =?utf-8?B?OGdaVGoxWkxIVTZtRHJYWTlhOFJVSGNsNDE1SjJXN3BuSmVkR21vQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d887bd-0021-4035-6f41-08df3a55ed14
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:28:03.5539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMm/xbLYdQOIXD2jOFnW2ESTKDBQgn1+kgWccYqT3FQx2cX3equLXYXTdzUOhXFh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
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



On 11/3/26 19:43, Graeme Smecher wrote:
> zynq_gem_probe() acquires a generic PHY (for SGMII), receive buffers,
> buffer descriptor space, (usually) an MDIO bus and a phy_device, but
> leaks some or all of these on its error paths:
> 
> - the generic PHY is initialised but never exited on failure;
> - a failed mdio_register_seq() leaks the bus from mdio_alloc(), whose
>    return value is also not checked;
> - the phy_device from zynq_phy_init() is leaked if a later step fails;
> - the SGMII dynamic-config and generic_phy_power_on() failures return
>    directly, leaking everything allocated before them.
> 
> Rework the error path into a single label ladder covering all of
> these. As in remove(), the phy_device is only freed when the MDIO bus
> is our own. Zero-initialise the local struct phy so generic_phy_exit()
> is a safe no-op when no generic PHY was obtained.
> 
> Signed-off-by: Graeme Smecher <gsmecher@t0.technology>
> ---
>   drivers/net/zynq_gem.c | 46 ++++++++++++++++++++++++++++++----------------
>   1 file changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
> index d28b97d01d08da50049280fe2f75277506a4b740..c15d2fc1318b42951648efe7ea67c6559589725a 100644
> --- a/drivers/net/zynq_gem.c
> +++ b/drivers/net/zynq_gem.c
> @@ -930,7 +930,7 @@ static int zynq_gem_probe(struct udevice *dev)
>   	void *bd_space;
>   	struct zynq_gem_priv *priv = dev_get_priv(dev);
>   	int ret;
> -	struct phy phy;
> +	struct phy phy = {};
>   

I would expect that you will create priv->serdes/phy/gt

because below you correctly call generic_phy_exit() but then obviously exit 
should be also called in zynq_gem_remove() too.


>   	if (priv->interface == PHY_INTERFACE_MODE_SGMII) {
>   		ret = generic_phy_get_by_index(dev, 0, &phy);
> @@ -946,12 +946,14 @@ static int zynq_gem_probe(struct udevice *dev)
>   
>   	ret = zynq_gem_reset_init(dev);
>   	if (ret)
> -		return ret;
> +		goto err_phy_exit;
>   
>   	/* Align rxbuffers to ARCH_DMA_MINALIGN */
>   	priv->rxbuffers = memalign(ARCH_DMA_MINALIGN, RX_BUF * PKTSIZE_ALIGN);
> -	if (!priv->rxbuffers)
> -		return -ENOMEM;
> +	if (!priv->rxbuffers) {
> +		ret = -ENOMEM;
> +		goto err_phy_exit;
> +	}
>   
>   	memset(priv->rxbuffers, 0, RX_BUF * PKTSIZE_ALIGN);
>   	ulong addr = (ulong)priv->rxbuffers;
> @@ -963,7 +965,7 @@ static int zynq_gem_probe(struct udevice *dev)
>   	bd_space = memalign(1 << MMU_SECTION_SHIFT, BD_SPACE);
>   	if (!bd_space) {
>   		ret = -ENOMEM;
> -		goto err1;
> +		goto err_free_rx;
>   	}
>   
>   	if (priv->cache_on)
> @@ -977,21 +979,21 @@ static int zynq_gem_probe(struct udevice *dev)
>   	ret = clk_get_by_name(dev, "tx_clk", &priv->tx_clk);
>   	if (ret < 0) {
>   		dev_err(dev, "failed to get tx_clock\n");
> -		goto err2;
> +		goto err_free_bd;
>   	}
>   
>   	if (priv->clk_en_info & RXCLK_EN) {
>   		ret = clk_get_by_name(dev, "rx_clk", &priv->rx_clk);
>   		if (ret < 0) {
>   			dev_err(dev, "failed to get rx_clock\n");
> -			goto err2;
> +			goto err_free_bd;
>   		}
>   	}
>   
>   	ret = clk_get_by_name(dev, "pclk", &priv->pclk);
>   	if (ret < 0) {
>   		dev_err(dev, "failed to get pclk clock\n");
> -		goto err2;
> +		goto err_free_bd;
>   	}
>   
>   	if (IS_ENABLED(CONFIG_DM_ETH_PHY))
> @@ -999,6 +1001,10 @@ static int zynq_gem_probe(struct udevice *dev)
>   
>   	if (!priv->bus) {
>   		priv->bus = mdio_alloc();
> +		if (!priv->bus) {
> +			ret = -ENOMEM;
> +			goto err_free_bd;
> +		}
>   		priv->own_bus = true;
>   		priv->bus->read = zynq_gem_miiphy_read;
>   		priv->bus->write = zynq_gem_miiphy_write;
> @@ -1006,7 +1012,7 @@ static int zynq_gem_probe(struct udevice *dev)
>   
>   		ret = mdio_register_seq(priv->bus, dev_seq(dev));
>   		if (ret)
> -			goto err2;
> +			goto err_free_bus;
>   	}
>   
>   	if (IS_ENABLED(CONFIG_DM_ETH_PHY))
> @@ -1014,7 +1020,7 @@ static int zynq_gem_probe(struct udevice *dev)
>   
>   	ret = zynq_phy_init(dev);
>   	if (ret)
> -		goto err3;
> +		goto err_free_phydev;
>   
>   	if (priv->interface == PHY_INTERFACE_MODE_SGMII &&
>   	    generic_phy_valid(&phy)) {
> @@ -1026,13 +1032,13 @@ static int zynq_gem_probe(struct udevice *dev)
>   					dev_err
>   					(dev,
>   					 "Failed to set gem dynamic config\n");
> -					return ret;
> +					goto err_free_phydev;
>   				}
>   			}
>   		}
>   		ret = generic_phy_power_on(&phy);
>   		if (ret)
> -			return ret;
> +			goto err_free_phydev;
>   	}
>   
>   	printf("\nZYNQ GEM: %lx, mdio bus %lx, phyaddr %d, interface %s\n",
> @@ -1041,13 +1047,21 @@ static int zynq_gem_probe(struct udevice *dev)
>   
>   	return ret;
>   
> -err3:
> -	if (priv->own_bus)
> +err_free_phydev:
> +	if (priv->own_bus) {
> +		if (!IS_ERR_OR_NULL(priv->phydev))
> +			free(priv->phydev);
>   		mdio_unregister(priv->bus);
> -err2:
> +	}
> +err_free_bus:
> +	if (priv->own_bus)
> +		mdio_free(priv->bus);
> +err_free_bd:
>   	free(priv->tx_bd);
> -err1:
> +err_free_rx:
>   	free(priv->rxbuffers);
> +err_phy_exit:
> +	generic_phy_exit(&phy);
>   	return ret;
>   }
>   
> 

The rest looks good.
M

