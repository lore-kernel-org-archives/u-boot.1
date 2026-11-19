Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF902606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zedmnsWn;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=FgxvIlcP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F067812C9;
	Thu, 19 Nov 2026 15:14:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qNOBsD_14pcW; Thu, 19 Nov 2026 15:14:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7189F812CA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795101255;
	b=HttpvCAziAbUsE9h8v4QnW3cyJ66hqg9KmfHw/I5nfw8/8NESt4IqwlreIK8URLle0pe
	 b1z8ZgtPSVgo2gcg8Q1I+DvfEFunv2pzOto/ZsDIOtpcmqmDB5R95HDIgLYEJvXIMiDwT
	 gKLBy8wMdJGNvnLGy72OMmy7tB7qAfBaZ7fQqjTBcKciz9jCt5fVO2JLa7J8gXzOu5Ngb
	 DbMiODnWW497pjhxPQJESWyF6W+GMTbz9eduK45IL+LAvj8ZQ+0QbgJg6iB0W1hPWmGC+
	 JTXTuFgWQ+GYz2I9kFDLrFbJbxMWNewijMHK3vLRARtDS1pdX77feuE80rT+3rtwoJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795101255;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sNyUr0+NaandfSi+jrLdKR4jYW8oYkgmRY8c+neiiRw=;
	b=KLrsWPj0HBzCZTM5BsNne4usQn+5y2h3R4gfZhCm7laOCWgXaudABDOe6uAOdTjD57Kp
	 1JF29dkvWsXxyWJkMPuM9gUtFGU4sDhms1X1cOxacgsJYkK3ZVOga2OtK4nfSZnBD1YkQ
	 fvQ/BLT1Pu06ozWa7HleY/z/YDcxhrVflcQN1u9uK/Ti9vIySzfF6A5yLiipaSHx5E/jj
	 XMAmk1vmsQx1fh0GUAYDwaW5GUnagu8mGaAd8pG4JjCuEsj12X19DF1qDxh87FL0MBCQ/
	 Lg/HaX7uQ3s/+lRPwaVUiXpdUq35hVtsUGaBD1j7145/5US3RDhfnDdZYd3ADxMjiNQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795101255;
	bh=sNyUr0+NaandfSi+jrLdKR4jYW8oYkgmRY8c+neiiRw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zedmnsWnD9tf111CFruaLr14TtuPs5MZHelY8dKxFfz8om1q674R02U+/s/6Y6bxx
	 iQOUlwS/f3gGwgqP72i0VqjRqjdoODeifB31T6+sy8PN+VEzCJnwOhUAMSwH9xwebL
	 wQJPLERnsthcBEf9Y7Sxpw2sMC4Sa2hjVePa/YlWoR9em3AdY7TeLLiNkrteLhckbT
	 VfqRXZ25b60+004bS0AA1h/6y3KhQTWhomC0Dsp4RHzxrMzFRMXZgrX1tDSy2Kp/O4
	 NDz69BuIaRkZgDRbrXLvjxXn16lIciA87k9rtzQUJNM0BoQB7iH9ZKghRZwI5MeiIy
	 /ICNSCMfGLvPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7189F812CA;
	Thu, 19 Nov 2026 15:14:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A277122B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 94C6260AA2
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:14:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dDKOoDb5gFsE for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 15:14:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D6C2460619
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=FgxvIlcP
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D6C2460619
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNyUr0+NaandfSi+jrLdKR4jYW8oYkgmRY8c+neiiRw=;
 b=FgxvIlcPpRI5Adz3hSUm+X4ag3y65ub6r7mXowNI9pEXNC4W95e0QEfqDwlEg4m+R9SBdt6ZMheIlasASOBuUAbqz17Un3gogxStRT9E1uLiUlmv97ws0hd1TqGwOaf3TSJ4wh2280Op8pX+h8OkpGbfOv9BLsa7E+wGXal+nH4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA1PR04MB12223.eurprd04.prod.outlook.com (2603:10a6:102:55f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 15:14:04 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 15:14:04 +0000
Message-ID: <a7390f3e-f6f1-4617-b7a4-df253673abe3@cherry.de>
Date: Thu, 19 Nov 2026 16:14:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ram: rockchip: raise error when configuration is
 unsupported
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
References: <20261116-ddr-multi-v3-0-fe9fb30a3169@gmail.com>
 <20261116-ddr-multi-v3-3-fe9fb30a3169@gmail.com>
 <4b4b6b1d-9676-4b02-a10b-506d3169800f@cherry.de>
 <CAC928Haq+ic8E622GsxdoOxFyXn9BHvNKxWTkV2ZsYFvA4HC+w@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAC928Haq+ic8E622GsxdoOxFyXn9BHvNKxWTkV2ZsYFvA4HC+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0146.eurprd07.prod.outlook.com
 (2603:10a6:802:16::33) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA1PR04MB12223:EE_
X-MS-Office365-Filtering-Correlation-Id: 504dfc43-279d-4db6-895b-08df464fbf8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|23010399003|1800799024|10067099003|4143699003|11063799006|5023799004|56012099006|261022105027099003|261022075727099003|261021135927099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: RgD+KXCPVuRvv07Y2SFJx6rL/2HJckm3o29D2Q+eXKLUbTtbImkk0+lD1xxWAquCH0qdFgp17u8yGGyHG7rfiRkl8WKheGoXVnSu/vE3pe29HverGiY5FzD9GCQulxkTwLQEUdijWBNOke1sCf7CT99Mb1D0h2vfObBtmKE1qTFZBa8lbsvK0oXL+Bk5XvGv03J2Qv5inrJaSVVUGVR3kSJUD34uaQ+yX4wci3nm2WPXDwTNAjWEbXFheE0qfKC5POKEEh40lLOjI3kS10vDnaW9RT6FUZtJVaIcHVSje58FEQufWhUXGplEfP+5WdUTR/woWzzsLH7d8L/5lbU1wWNMe3OPJiX3hmpKSwvZ7NNvjA2FauASptLev5xzcYS0dBkg1MBF2peGATLtT+o0FTVCBR0zOFq98KgDIc2WQy/FQfCKKvhW2ioKaXU/RfNYToPVT9szzrvkXsII1ZgxHWdR8yJvXmiO+pXQJ/JeN+PiikNc80KffAzzv4vygWM4KbMX02YSW5dZpwENSiKfDuQhiORx40QGENMDMjnC+HGudi4XsduLIRRYYnOKz2hrDCL+6VU4EtWJj7vs/9FzhBcKqulkjeOKTkZQR6alPjDkx3DjzmbqF/tQSHT2L5EJYFe1wCULTvA471hIM+4pJbtkauWUTKMVIa8ZVJ4t+Rc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(23010399003)(1800799024)(10067099003)(4143699003)(11063799006)(5023799004)(56012099006)(261022105027099003)(261022075727099003)(261021135927099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUlldDZhMlRaQlhiNkg4cXRHb1J2aGJkc1RVVk1PSE9pOU51eHpMYVQwUklp?=
 =?utf-8?B?aE5lZ2xoczNkaDllVzFYSTdZWEw2cUdxM2hMV1BaS0dVZ1VGVjVVZld4Y0dJ?=
 =?utf-8?B?QThmTlB4NjUzUE9FcnVxRnlIcnFEWW4yU1g2Lzc5Qm01ek9DNmpVclQ0OGhN?=
 =?utf-8?B?Q09WdHRXTjBvdE1UOHo2TDRHMjVEc0lmVnQyZS9MVGE0WUZxcUtXcHRoY1RE?=
 =?utf-8?B?a3Fpdk9IQmZIeTd5WEpIV0VkYkNGY28xempDUHh4MW5qUXZPZWJRSEdhUGJq?=
 =?utf-8?B?NmZNVllCZXF2RGI2aVkwNUkxS2lDd3I4S2xrNWZuYzRTMnRKaG44cktWalpV?=
 =?utf-8?B?ZVo5cG5WMWJjclp4MG9pYkdNRXZqV2ZVMlc4Y1l3a0lBdEJpZFZmZm5kbTdu?=
 =?utf-8?B?dW9uZ25ZdmxXVkVEWkttSmRQQ1p0NExkUTYwR2pGYitNNjVRNkVXY3FBZnhI?=
 =?utf-8?B?RG5HT0xRN1B2TXBaYmh0QXNtMmx3U1dOV3RybDJ1Q01CVjJDL3dseHlhQ05v?=
 =?utf-8?B?Z2JjU09FYjJlQWtRR2JyeXVjK1BDdTVkSk9Va0xjejgrMFFJYURvYzB3VTBl?=
 =?utf-8?B?L0JYZEIyam8vRlBveGN2S0NKMW9NZ0t2TE0xbDhOcStjWGw5UDlmMTZ0NjE3?=
 =?utf-8?B?MFZvSmZLU3FmWVVhc0xTTzFCWU1EVnNXRFVXTTRiR2l1U1BCbVpVYnFxVWlR?=
 =?utf-8?B?R3ZsTDh3WWNubDY1QlpSSGtUWW1BSW0xa0srN3A1dU56MUlERm1PRHJMSXhD?=
 =?utf-8?B?a3pJSyttVEhmQk9jVk1hQUNubmtnRWhjTTY1ZXNrT1J1QUI2bnE5d0V4UFFx?=
 =?utf-8?B?Nlp6d29VUUw0Q0ZDZ3FwUndmUFE0dWIzeHRJV29QTE1XN3kxK0ZDVTlQUk1I?=
 =?utf-8?B?NDhseGxyRzMvbU0rc1VERlVUMTNyQUcxMnFJdUFsbXZoR2JRWE1QaE1TczB1?=
 =?utf-8?B?d3dnN0VpZ281dmJidzBWS0hvZ1lvNW9lVTgrek9QM1BIT1lwSWNEYU1ZSHpx?=
 =?utf-8?B?Tzk2YzFoRWdBb0RhbE9TSGlSeE5TVSsrY3JKT1VXcURXWWtQUFN6cHkrSkRx?=
 =?utf-8?B?ZkFLVktocWtwa2RSd1BGdjBkYUFlVVFac0s3QW90RDcwRm04MlNKQzdWaTR3?=
 =?utf-8?B?YUtqN1FiZVllVndFcnJMbXB4NUxGa3ZZTEc1RGdmV1BoWU44OFlqck15MzJT?=
 =?utf-8?B?YTQyTFphYlBCSjlIQUJsUEFHbVk3eElEZkxzRStpTVF4VWxYU01sSER2UUR4?=
 =?utf-8?B?UEN5MjJscmg4d2N6ZERIcU5INHZyS1ltZ3IvbEovRlpKQnU3RDNRR0hUYjR0?=
 =?utf-8?B?d1VoSEI3eXBwc3liU2RpMVJCVnF0OENOQ25POXU2WllTaHh0SXJ0azd1ZlpG?=
 =?utf-8?B?SnhKV1dseFhRdGN2QzNuZHlrZXBxbHE3SHJNRWJDVUpTbmFlWW53UmRzNzFv?=
 =?utf-8?B?Wm5yMS90WEh3bXRGWTdJMUdna2h4dVhBZlJJUi96UklKRG5aVkVEb1U3RzlY?=
 =?utf-8?B?cmVScXgzZ3pwNjcxZVkyelZudG9HTVFKSGNWSjJiUjM3T0NSVElLbWNNVGRT?=
 =?utf-8?B?dDNyWjhab1c1RXBPSkVOU2hvd0Ewb3Bic01yaG4xT251bTM0R2R0OTlNL25t?=
 =?utf-8?B?dFdGeGNpakpLd2JBY05VblE3dkhiM2JsS0VPd0FFS0Nsc05aZVJFZ3FoYW9B?=
 =?utf-8?B?c0tsYkZIdVpBdVA0SlY5Ris4dVBHZ3lKcVcyeUFtMndJTmlZMlZsMi84Wmt3?=
 =?utf-8?B?VUxSYzdFN0JJWGV4RFBaWjduR0NvdlhnaWpDOWxVOElmMnV5MTJVVVBxREd6?=
 =?utf-8?B?WmhodXZPdXpwM3hITjVtb0MzTit1T1NaMi9ISGxaUTZSQWtIRm0ramI2dTNJ?=
 =?utf-8?B?dEtQZkJod0VnOHFZUEwzZDJ6VlIxdy9Ia3R4TzZJUTBUcmpZN1FTNWFic0ow?=
 =?utf-8?B?S1NJK0V6eU85VFBSS0M0VXJiRjZDaUMrTXEwT29jRzd4UkZPVkpQTFdDMk45?=
 =?utf-8?B?d0JsVHVBSSswQWYvdXdtendTZUpzUWExZVhrWEVGWFFEQ0VSVkREQVpBRGNt?=
 =?utf-8?B?eGdUQ1RRWDliT0JrallMY1A2eElkRWxZSXFVZzdLUlhsQUlDNjhyREUvV2Fq?=
 =?utf-8?B?WUtBeTYzVGMvcGxQd1ErTk5GZGxrUkVpZnFlb0lFNmxBVVNzeFo2Sit2bnhL?=
 =?utf-8?B?NU9ZNUxXazRCYnVMdXZlOGV0UkNVVGg4NUVkTUJPeDVkQnliMVVub2cwdysv?=
 =?utf-8?B?YXp4THA4YTFlbXN4QzEwQWRrTnF3cGdKT2NPQW9ieFQrNFRKbG91eUJLK0l4?=
 =?utf-8?B?akRIbm1wWUxBR0o0Nkg2ZVVES2hWOWlmZUFCbU9ib005OEkvSEc3aFN2Tzl1?=
 =?utf-8?Q?P6gSuKlloV20f5Wrt13XqVxlxUUbfocr8ZMamvfmuVUiy?=
X-MS-Exchange-AntiSpam-MessageData-1: smAUSrw0usfkbKPsX1ZTkaBvw4uBe19YEq0=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 504dfc43-279d-4db6-895b-08df464fbf8e
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:14:04.2086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvFoJ3TcyQ4TwKWIF2v/o5pUd0KH9Zs4FSl3fopUjb7xH9K6ysVndgLo/aTEciWijg4MjlGGAmP6tu2DMi1mTfIXAkZTPxJfd1aQsDPii9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB12223
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Massimo,

On 11/19/26 2:23 PM, Massimo Pegorer wrote:
> Hi Quentin,
> 
> Il giorno mar 17 nov 2026 alle ore 17:40 Quentin Schulz
> <quentin.schulz@cherry.de> ha scritto:
>>
>> Hi Massimo,
>>
>> On 11/16/26 7:39 PM, Massimo Pegorer wrote:
>>> The PX30 and RV1126 sdram drivers support more sdram types but only
>>> one type at a time, really. The type to support is selected through
>>> RAM_ROCKCHIP_XXX configuration options: raise a compile-time error if
>>> more than one of these options is selected, instead of relying on a
>>> debatable and embedded priority order to choose the one to support
>>> among the selected.
>>>
>>
>> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> If we add ROCKCHIP_RK3399 to the depends of
>> RAM_ROCKCHIP_LPDDR3/RAM_ROCKCHIP_DDR3 and RAM_ROCKCHIP_LPDDR4, I think
>> we should add a similar check in the rk3399 driver to refuse to build if
>> there's LPDDR4 and either of RAM_ROCKCHIP_LPDDR3/RAM_ROCKCHIP_DDR3
>> enabled. What do you think?
> 
> Unfortunately I did not come to a clean solution for the RK3399 sdram driver
> "singularity". At least, not enough clear for my taste. So I left untouched,
> open to discussion.
> 
> Let's suppose we also have ROCKCHIP_RK3399 in the dependencies of
> RAM_ROCKCHIP_LPDDR3 and RAM_ROCKCHIP_DDR3, something like:
> 
> config RAM_ROCKCHIP_DDR3
>          depends on ROCKCHIP_PX30 || ROCKCHIP_RK3399 || ROCKCHIP_RV1126
> 
> config RAM_ROCKCHIP_LPDDR3
>          depends on ROCKCHIP_PX30 || ROCKCHIP_RK3399
> 
> Some compile-time checks in the source code can easily be added to raise an
> error if LPDDR4 is selected but it is not the only one, or if none is selected.
> 
> The point that annoys me is that, in RK3399's case, the two options
> RAM_ROCKCHIP_DDR3 and RAM_ROCKCHIP_LPDDR3 are the same thing, in the end.
> If it would be possible to have their values coordinated, I would be happy,
> but I do not think it is. Using the Kconfig 'select' statement will force
> one to be true when the other is selected. But unfortunately, this does not
> work when unselecting options. So, if one is selected but the other is not,
> what should we do in this case: raise an error, or silently ignore it since
> it does not affect the build?
> 

I think it's fine if we have DDR3/LPDDR3 selected but will use 
LPDDR3/DDR3 based on Device Tree. We can make them really mean something 
by gating LPDDR3-/DDR3-specific code, but I'm not sure it's that worth 
it right now. Something worth investigating if we need to shed some 
bytes in TPL/SPL.

> An alternative could be to use an RK3399-specific config option, something
> like RAM_ROCKCHIP_DDR3_LPDDR3 but... ...it's quite disgusting.
> 

Nope, don't want to go this route :)

Another option is to make the RK3399 driver capable of handling 
LPDDR3/DDR3 AND LPDDR4 at the same time (no autodetection of the 
populated DRAM type, still read the type from Device Tree), then it 
becomes less of a headache. You can have LPDDR3/DDR3, and/or LPDDR4, and 
it gets easier in the Kconfig symbols.

I quickly came up with (didn't test aside building):

"""
diff --git a/drivers/ram/rockchip/sdram_rk3399.c 
b/drivers/ram/rockchip/sdram_rk3399.c
index 6fa8f268770d..22d196f1bec7 100644
--- a/drivers/ram/rockchip/sdram_rk3399.c
+++ b/drivers/ram/rockchip/sdram_rk3399.c
@@ -1632,7 +1632,7 @@ static void set_ddr_stride(struct 
rk3399_pmusgrf_regs *pmusgrf, u32 stride)
  	rk_clrsetreg(&pmusgrf->soc_con4, 0x1f << 10, stride << 10);
  }

-#if !defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
+#if defined(CONFIG_RAM_ROCKCHIP_LPDDR3) || 
defined(CONFIG_RAM_ROCKCHIP_DDR3)
  static int data_training_first(struct dram_info *dram, u32 channel, u8 
rank,
  			       struct rk3399_sdram_params *params)
  {
@@ -1723,7 +1723,9 @@ void modify_param(const struct chan_info *chan,
  	clrsetbits_le32(&denali_pi_params[76], 0x1 << 24, 0x1 << 24);
  	clrsetbits_le32(&denali_pi_params[77], 0x1, 0x1);
  }
-#else
+#endif
+
+#if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)

  struct rk3399_sdram_params dfs_cfgs_lpddr4[] = {
  #include "sdram-rk3399-lpddr4-400.inc"
@@ -2964,9 +2966,11 @@ static int sdram_init(struct dram_info *dram,
  	}

  #if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
-	/* LPDDR4 needs to be trained at 400MHz */
-	lpddr4_set_rate(dram, params, 0);
-	params->base.ddr_freq = dfs_cfgs_lpddr4[0].base.ddr_freq / MHz;
+	if (dramtype == LPDDR4) {
+		/* LPDDR4 needs to be trained at 400MHz */
+		lpddr4_set_rate(dram, params, 0);
+		params->base.ddr_freq = dfs_cfgs_lpddr4[0].base.ddr_freq / MHz;
+	}
  #endif

  	params->base.num_channels = 0;
@@ -3067,19 +3071,23 @@ static int conv_of_plat(struct udevice *dev)
  }
  #endif

-static const struct sdram_rk3399_ops rk3399_ops = {
-#if !defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
+#if defined(CONFIG_RAM_ROCKCHIP_LPDDR3) || 
defined(CONFIG_RAM_ROCKCHIP_DDR3)
+static const struct sdram_rk3399_ops rk3399_lpddr3_ddr3_ops = {
  	.data_training_first = data_training_first,
  	.set_rate_index = switch_to_phy_index1,
  	.modify_param = modify_param,
  	.get_phy_index_params = get_phy_index_params,
-#else
+};
+#endif
+
+#if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
+static const struct sdram_rk3399_ops rk3399_lpddr4_ops = {
  	.data_training_first = lpddr4_mr_detect,
  	.set_rate_index = lpddr4_set_rate,
  	.modify_param = lpddr4_modify_param,
  	.get_phy_index_params = lpddr4_get_phy_index_params,
-#endif
  };
+#endif

  static int rk3399_dmc_init(struct udevice *dev)
  {
@@ -3098,7 +3106,21 @@ static int rk3399_dmc_init(struct udevice *dev)
  		return ret;
  #endif

-	priv->ops = &rk3399_ops;
+#if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
+	if (params->base.dramtype == LPDDR4)
+		priv->ops = &rk3399_lpddr4_ops;
+#endif
+#if defined(CONFIG_RAM_ROCKCHIP_LPDDR3) || 
defined(CONFIG_RAM_ROCKCHIP_DDR3)
+	if (params->base.dramtype == LPDDR3 || params->base.dramtype == DDR3)
+		priv->ops = &rk3399_lpddr3_ddr3_ops;
+#endif
+
+	if (priv->ops == NULL) {
+		printf("no ops found for requested dramtype (%d)\n",
+		       params->base.dramtype);
+		return -EINVAL;
+	}
+
  	priv->cic = syscon_get_first_range(ROCKCHIP_SYSCON_CIC);
  	priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
  	priv->pmu = syscon_get_first_range(ROCKCHIP_SYSCON_PMU);
"""

Of course, we need to update the existing defconfigs to reflect that 
change as !LPDDR4 used to mean LPDDR3/DDR3 but not anymore. An 
intermediary step could be to have DDR3/LPDDR3 default y if !LPDDR4 so 
we avoid changing the defconfigs with the driver patch, and then remove 
the default y in a follow-up commit by making the rk3399 defconfigs 
enable the appropriate one (easy to find based on the Device Tree they 
include).

Finally, with the above diff, you can technically build the RK3399 
driver without any of LPDDR3/DDR3/DDR4 enabled, which can be remediated 
by an ifdef check at the top like you've done for PX30/RV1126, just that 
we *want* to check that their sum is NOT 0, anything else would be fine.

What do you think?

Cheers,
Quentin
