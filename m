Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C46606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 02:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MkgtXiQZ;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=dTxWgWox
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4799D407BC;
	Wed, 21 Oct 2026 02:27:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gb4fvrzvlngO; Wed, 21 Oct 2026 02:27:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6692140758
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792549650;
	b=IPhWodpTrqMaXfXSM2BDrPAd0/nmJIARyi3CzYq5acnkyrKp2GWOgupoMPrnsFP+3nPy
	 q+4+PIOO5xahIfIqQq567MxSHdhCV6rrXJNxbU30Zf7a7ixeTd7C9gsgxZAwEXF795+c3
	 8rlhqwcR5pqhhPKd0oTQ6nptHFYq4QliBsazj2EGSI3JYzd39lLq1CqWuBlaFAsUz6SgQ
	 CrKi0I9w3DUZ71WwFSQ0WfzHXLFDy5xvg/MUqIT1kmphIbmuz4Aoh3tt5/vLkH8Nvxcjz
	 sF7PHq8+ulI3h6cbA9V/1yarHPpn0UUzU0gwzG/QDx5LvcwX814uXcWY3waxiXi/31w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792549650;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=KZ+BZ2zER8BC6/BePlUCbDQKivQFv4YtmV0GD9OBqdw=;
	b=sfMpWT9tAEkl1OdhuljDPJD8fnYM6KLJV3IMuRK3l/LpaZ9lFOjNFb0CS8km7AU5GFrY
	 Px5rDQunpxV6jX89qvCrb07hQguLOSm74Za/0MewFEgMhaoJY9cYbNSyCbOd47+sJZwg1
	 ZZ5H9LFguS9YdYq1vpigiMHT3tzLJgeLjMaWjGagKLntm5Kh+Z4t3jhXw2EyEDRQ4yFsX
	 48sIz7KiDMUpUWX+JBVwZ5qIhMa4n7nB5gls8Rvh6t8b4mOHnmp6dvXVAxga1VSXsak9g
	 n0rCQr0XFMOCP2uNaZK99ShbwFbgXqirm7uiG7nYIxgC+5U1wl8qwB83LRcvIvk/azQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792549650;
	bh=KZ+BZ2zER8BC6/BePlUCbDQKivQFv4YtmV0GD9OBqdw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MkgtXiQZfEiRmidEfmuE4JOFtUlalKyNSi6ALqhCek5p3D8tuRf6ODYCDLv5XihqI
	 Wnq6vdJ80OvNrY/b3m1BvQD7XK6Eh2ZQpwEci95/3CY/MJPAmNCj8knxcpY1vjYiwo
	 CqLHmWgzRvPOkszUNXcKqmqNgDTcl/9ioa/M8Y9gAdLZCSk+JBpNChmPASpr+Oey+a
	 r5P8dF10z/MKnIYFsbeHDIHOtPCLCfPXV3j8KVmOdKO84akMKnbjx7yG7+tfTqJVqR
	 MEfzjKrEQqcX7siOwqmudibaQx4DV3aMJrC2L+cNA1W/qaRLGqAPnsdLjcQgBjbG3/
	 +/455zfSyiOeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6692140758;
	Wed, 21 Oct 2026 02:27:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A937995
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:27:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2C85A81086
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:27:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mw6auOlID6WX for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 02:27:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3A96980F90
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792549648;
 b=Gvhopes0JX5p+HwH0zEzs0AKCi/7euAryuUNtaMthhdhC+NZSotVoE4Rz4UPOEO20j7S
 TlAiwPm4CMcL33qn3QgLMj2/GOUNxPePSoAaJnDHcdkhq9hv56jNPEQNhOk8V1HgFbw1i
 Xie0IL5fLY+GTBDC+pKBRdYY7ICZGDgcb+t6zOQ7zKVu7w0dCYpCREovTtm2TyGSjbxhw
 AFqUrsLZ9+WtSI6cdNSGiqOdb73zYP9nTftdYEbxqjhRnFm68hkkjbIjruRAEq2AJ4YE+
 EZUkI5x5fHoZFTTfQWUA8h5VNXbRxUuHPVuGVGbWUbIwSRzFm8hecgjaXXIAeIeeu0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792549648;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
 X-Virus-Status;
 bh=KZ+BZ2zER8BC6/BePlUCbDQKivQFv4YtmV0GD9OBqdw=;
 b=TpBK5nnKYNw0R3O7zFGTBG85Hi2904UfiXpS8rb/+A4ucSU8RDx8DU1pL9anXDZSkxc/
 2Tv79O4V12U443FLr9HF9CrbMngFuZdQTFCKGERVOufi8S/aaIdQNb9b9YrUI0vSTqRnS
 zZQ49cM8ZP3xY0Rrzl04DL6bD4BloF1uZGEJ3fBL8G/M0whJ805MRrcq+IVPyrwePZstz
 /4ApfJG0urUSZOmjKTg0n1HLhAoghW5xARu9MsznBDsOMMQ8X/iM+sDmu9xQk+RWJ8f43
 ffryd3NO7s/IPNDScGgNVJN+CQPYdj6ZYDKdBtYC36K1yRjZ74zDvawsUopFsSwLXSw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=dTxWgWox; 
 arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=tien.fong.chee@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=dTxWgWox
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A96980F90
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:27:26 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9389C844F6; Wed, 21 Oct 2026 04:27:24 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85AF28056B
 for <u-boot@lists.denx.de>; Wed, 21 Oct 2026 04:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScZ3IfFZTRHwd7yuKTOcPFwJGN641UxlGshyQs48VV/L1bb1KvzdHP+uwec6KkWHAdcznOUhN8O9qJ8rQ5KXuiGiZpCgGXOGwy1CEmXlxd8lUYpGdr35x9T64izYevymLPb+zjiBsoqcnkuHDQeUBl9DaPDuVUscbXohoPEFP7vkPsKrsvOsRh4BnTMAUOjbnfWZIIk51cTjzw6DvOFgAOsXdHsfU3BmXTFO0XqlxoOKsL3YIH0niEzAY0D+Ok9ymAsIDFY5jlRWnpexopV8iQXkbu9e+Hx2DToi+uzLF9ZqXAmRbJ8Nz60hNqvqToT4V6JYNZRqtO6cqujfYTRqiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZ+BZ2zER8BC6/BePlUCbDQKivQFv4YtmV0GD9OBqdw=;
 b=nz3ms/hQ09P72m/2f3L76TBfvdYtV/agx7WGW94Ah9yLfmPVKXffku5oc4ttGltgxDLqLOQbDan319A/j/YPUy2EF5tlzCDFkaoF9Kmq4rPQBmKdn4TvMCSWekbJW9tqLQbH4zLKVTnUesCMMmgaXtr3szK4NWSD+R/4VOe9Z2oxioGWR/vcdsWXQSA5O5l5Uuy5vtJDgfstYKUeA9p8dEqfA26t/vybVqgPITGkE15mOzMKEXpisqaItd1Jsq36jnnh8HH0Pewncdkcw9R4ihzaDQjFgteGT5sye4SEjPjhflS9Bj77QPDUM6Oh7FN2dDZTy86qWje15SXC5b/1wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZ+BZ2zER8BC6/BePlUCbDQKivQFv4YtmV0GD9OBqdw=;
 b=dTxWgWoxMNU0OK+9opEW30CoM9sMir+NryoY6tLwGGytwyVnO3El6sesqm6sacGAYbn1TupgDPRKg4ioAHLace5FoavpGh8mb+K1vwpNjchek6QT5fNOL7q5hJayuy0hVXFHcGOiNOrOD77B9AlLy3ZnJtsZP+9k12WY+z9DioyOX2dHhtqgC0c2as2KtR9IK/F/8CYGd9YYmN8i3WFdnFs+NfuX7tJWIJN4yhyyHMnHWaZByYEGWTAnWkOxuPfVjRRYVHL6xwIxoKJ6Br9RHWT3D2V11yFutZUZaf7/nbEWnNeI9MDpq+9JytJZXAz3gnyndlVdWtVmIMtzCnrvVQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14) by CH7PR03MB7833.namprd03.prod.outlook.com
 (2603:10b6:610:249::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 02:27:15 +0000
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d]) by CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 02:27:15 +0000
Message-ID: <2b13e935-9ea0-4e3f-9aa6-850e2d35b5d6@altera.com>
Date: Wed, 21 Oct 2026 10:27:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/15] ddr: altera: n5x: rename is_ddr_init_skipped()
 and quieten reset log
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20261016044047.21496-1-chen.huei.lok@altera.com>
 <20261016044047.21496-13-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20261016044047.21496-13-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0034.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::21)
 To CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR03MB959535:EE_|CH7PR03MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: 679efaa5-fa60-47b3-f364-08df2f1ad1fc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|55112099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: MhBZTbv92rlz1r6tdlWtn2TDIp+TDK94jNyxwSRz7WuRrQfxX3BtO5MdoNtkP1t62xUHbO/c5/GVZ0TQbKUlv0xSMlUW+EWaGHTcQKgUITwk3Bdsl6N9af3V3fWKrEh155ukaKMez/33rRa9Cniq0cpnXNMt45W+E012dCGSP8dJX17qN4TfbV24KZ/4c9hRwHwEQlAssogNJaEudpgz/YZOsittfesYdJUSFCZbjkSVwM1+Kwmf+k6vjNSKZ6y9+EvUgmhNss/fYc0lTJaA3PGP1vwueBonhX0Um1Iqs2lsyAxzJTi6ktUToKNfTvQxhKyXJn/x/2H5h8SS9/Z8KgchGIWEePjZuyYy8SxYFo9TnKXe4Z+adkEnO8aGm3IcFyKC8gOrH4/0AfkdbjWJ6LSbpxppDKObaDQ/1bjcuryvO0EUuCryAnJpbJE6Jq8LdlFO+JgPN10M+0VnyzY6EexJ2waEgVDShd9VRL+fyOBYYqDeRnP3WwvSO1srRmMzABQ9IdNBR/SWqve6f5812as5jPqCJc6rN63jkv+7dxqgwR4cimB+rn0e5zB3+UpoONtK8zpuoVsynDFiZiH+3CgnzZhYxmwEErelQrI8TsoKPE1uxO7hrlq6SsDdHQN54jwgeYg743fuU4lozH0U+A5nAEpoPR9MzVxBvK5pBwg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR03MB959535.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(55112099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFVnL0hUOUw0M0RMTXRmYUZXMU90UlNoTzVnWmtPak8yS281WE12MU8rUlZ2?=
 =?utf-8?B?cVFWVndCNitlQTdzVWFERXVLN2gybTQvcEFsVy9Lb0l5eWZYR3lYQUtQZzBM?=
 =?utf-8?B?SHF5ZUdlRUIxcmswN3FmQ24wWG5xS3RlUHNUWlNucVpua2tYajU3blVnRlFr?=
 =?utf-8?B?ZERGLzN6NklQU3pMSytzZVhXN2FkZGdZQmF2bVZPNWhnVmI4V3V2YXh5SHY4?=
 =?utf-8?B?L1NRb0RBSVJMdlN2OWJTUmlub0Z5b3QzSFE0WllUQVQzZS81N2h1RFFoRWhC?=
 =?utf-8?B?U2tSY2EyTTNXVENvT2Y2OXBqa3RudDc5d2YyVjl6cHR3ejVVaWtFSm9QSm9x?=
 =?utf-8?B?ZWRxTG91M2NoTEJYVmNpL2ZUNGpTVHo4N2VoT0trTG5yTDQyUHVWV3R3cWxZ?=
 =?utf-8?B?Q1p3bEpGU2pqU28xblZoekRJZkFVRHp5eE9WYWNqZ3dXRzZEVkE5L2pueFlJ?=
 =?utf-8?B?aU1BSmFFMFVVL25kL05zZStrSndrdzFReUlIVjNJbzcwUCswekcxeXI2N1Vp?=
 =?utf-8?B?Y2JSN0dsZHJ2aDlwdGkvankyaGhldGIwSlFKWDBlTFRTREh0Rm0xa1hxUVhV?=
 =?utf-8?B?QW1iMFQrT1NCK3M0cHFZeGRiSnYvTGhqSzdKR2loQXFIclVLd3NKNEJhQnBz?=
 =?utf-8?B?K1lEUjZGS0l5ZmNkb002K283ek1ncm1IamN5RkkzZ25UWFNyUWx4NFNCMjBW?=
 =?utf-8?B?T0RKYnV5Qk1GejR2dmgrNTZQK0xXNk9BanVzWC9Yc21YR0Yvd0NnMVVvbUZx?=
 =?utf-8?B?bGhuYTlEUVJVNXlCajE3akFWcHZ2aFVlaDExQ2Rnc0xYWFJVNEdxUjJKNjMz?=
 =?utf-8?B?WWZoNVpSUWhXUmhHcHoyc3BidGliQmh6VGJFL1NIQkhtS25JZUg2U0RDdFRY?=
 =?utf-8?B?R2orcEJJaFlJeFBGd3hWWEI5eGtITCtmdHlWY3p1NWl3UU53aVA0M25hVk9l?=
 =?utf-8?B?UW5OM1hpT0xsL3VXT01aeGF6dmlwbU40NDY1ak05RWNVRnhkWE4xRDdUQ0FI?=
 =?utf-8?B?WldFN0lHZTBxS0hBUkNaOWZPcVQydjBVVTA1bUtweWNPZ1FCTjdUTHR0bUVi?=
 =?utf-8?B?Nyt1VkhLVkM0QnpjdzJQZFdoakplSDNDQkFsQ1IrQ3JabEc5cWRNWGUxTTZU?=
 =?utf-8?B?VmNvR21TUkxUbDhOQWhteFJpYUJsd1hXRmhOcTE5ZTN1M3YraHE1QmhlUG05?=
 =?utf-8?B?TGtydm1BcGFlbFNZOVJvSlFHMEFrUnVzbE00N1JMTVJaZ2pYbEZXcjNCb2p5?=
 =?utf-8?B?VTNaZnhQMzNvMEprT09DSy9qRWFhVzF3OWk1SDNQam95d1hDa0tIaE5pTHF3?=
 =?utf-8?B?L1NyYmFvK093VlZCcFl3N1BqbjN6R1VzZFpBako5Z1dlOXhxVGgvak5Dc3I1?=
 =?utf-8?B?d2d3OGdhcDVKZnk5cW9XWTI2d1IybXRGencwc0ZuSWorOHd3Q25vRGlGZ2FL?=
 =?utf-8?B?UjhVc1lDZm56bTRsNVJXMTdmSHBvaEp6VFBLYnZaTk45SlFNdXRUSGc1ZHd4?=
 =?utf-8?B?UjVWMC9SUTBORDZsL0syUy9uc1dYVituK0dxK0ZZMFB1WnNXSjRsOE1VWlda?=
 =?utf-8?B?UUpzZTVwL2lQclRQLzZBZDVUdXBhSXpjVmFGMmxCR0YrMWVRdTlGcEJ6SnRD?=
 =?utf-8?B?RmlEb3VITnc0MDB5ZVAzdHN6T0hLcWNFc2IwRU80SXY0eE9kZlRES2ZtTFlQ?=
 =?utf-8?B?dVR2eE1KeDBTZ1RCaEV5RTJSVUVMRUgvRUlFV2VBOUo5SFRIZWpVMng1QnhY?=
 =?utf-8?B?VXRmSHZ1WDhCKytjdlg4MkJpOVRUZ3pzZVlDUEk1NFFDQUlMWUVGM0VuZzUw?=
 =?utf-8?B?YUtNL0grVWlVQ2pXMXpaT2pHN3VRK1FvTmRacmF2Um4wZTZGZkRxNU9LMC96?=
 =?utf-8?B?VDZmWDU3cEd2U1Bvai9VMFhCZlY5T205aXZzR1RiTTBQb0pEK2pGVHg5SENC?=
 =?utf-8?B?NFREdE5xMERoaTcwdVh4c1MyUGVpUjR2QlhEMVVMdG4zclUzcVFzNXRTRCsy?=
 =?utf-8?B?QURkQjMxMExDL0pkblpIR1A1S3lUaFBScHJxYlBBbjJKNmE4QnBCU3NRV2V6?=
 =?utf-8?B?OWQ5dEt1b3pHMWJRUkh4SGRHSC9MOGlJVlpZck1SL05ZT25IdUduZ1J5aUNE?=
 =?utf-8?B?eDhPZ0ZJUmRTc0ZjNENvV0VnSXByUS9PNWdoY0pMVDI4bW11SFpNci9Yd3Ra?=
 =?utf-8?B?S21tVE9YNkEvR0hJS1BkZ2c1ZDlVZ0s4R0FPU0FIR25GV0Q0aWFyQ2swcXE0?=
 =?utf-8?B?blJlL2RScWVuR21tejI4aDJpSjJVdXp4RzlJWWVEVDJUTTlCdGZOVVNmeWZY?=
 =?utf-8?B?SjUvL2VxSC9OeWdrOEh5NnJ2ODJqNi9wRTBLeStaZEY2a1BtU2tnQm9SMzN2?=
 =?utf-8?Q?fgf2c8mqiNYcdKjQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679efaa5-fa60-47b3-f364-08df2f1ad1fc
X-MS-Exchange-CrossTenant-AuthSource: CHBPR03MB959535.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:27:15.1202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttSzWObItUW2zo6L5ALMb1mTgoqUH2vUUEF6r6oai0T5grcGtY0jHndmCZIFE1xNNMaqjj00vzUS0LBFfMh5sDgETHhp+KrHvCLtnGJPgEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR03MB7833
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 16/10/2026 12:40 pm, Chen Huei Lok wrote:
> Rename is_ddr_init_skipped() to is_ddr_init() and invert its return value
> so the helper reads naturally at the call site (true means DDR must be
> initialised). The decision is otherwise unchanged: init is required on
> POR, skipped on a warm reset, and skipped on a cold reset only when the
> retention bit is set.
>
> Switch the reset-type reporting from printf() to debug() so the reset
> cause is not printed on every boot, and add the NCONFIG, JTAG_CONFIG and
> RSU_RECONFIG cases. Define reset_type_debug_print() above its first caller
> so the new call site does not trigger an implicit-declaration warning.
>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>   drivers/ddr/altera/sdram_n5x.c | 56 +++++++++++++---------------------
>   1 file changed, 22 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
> index 244bf8ccb8c..be512cd33b1 100644
> --- a/drivers/ddr/altera/sdram_n5x.c
> +++ b/drivers/ddr/altera/sdram_n5x.c
> @@ -468,17 +468,17 @@ static enum reset_type get_reset_type(u32 reg)
>   		ALT_SYSMGR_SCRATCH_REG_0_DDR_RESET_TYPE_SHIFT;
>   }
>   
> -void reset_type_print(enum reset_type reset_t)
> +void reset_type_debug_print(u32 boot_scratch_cold0_reg)
>   {
> -	switch (reset_t) {
> +	switch (get_reset_type(boot_scratch_cold0_reg)) {
>   	case POR_RESET:
> -		printf("%s: POR is triggered\n", __func__);
> +		debug("%s: POR is triggered\n", __func__);
>   		break;
>   	case WARM_RESET:
> -		printf("%s: Warm reset is triggered\n", __func__);
> +		debug("%s: Warm reset is triggered\n", __func__);
>   		break;
>   	case COLD_RESET:
> -		printf("%s: Cold reset is triggered\n", __func__);
> +		debug("%s: Cold reset is triggered\n", __func__);
>   		break;
>   	case NCONFIG:
>   		printf("%s: NCONFIG is triggered\n", __func__);
> @@ -490,34 +490,39 @@ void reset_type_print(enum reset_type reset_t)
>   		printf("%s: RSU_RECONFIG is triggered\n", __func__);
>   		break;
>   	default:
> -		printf("%s: Invalid reset type\n", __func__);
> +		debug("%s: Invalid reset type\n", __func__);
>   	}
>   }
>   
> -bool is_ddr_init_skipped(u32 reg, bool is_ddr_hang_be4_rst)
> +bool is_ddr_init(bool is_ddr_hang_be4_rst)
>   {
> -	enum reset_type reset_t = get_reset_type(reg);
> +	u32 reg = readl(socfpga_get_sysmgr_addr() +
> +			SYSMGR_SOC64_BOOT_SCRATCH_COLD0);
>   
> -	reset_type_print(reset_t);
> +	reset_type_debug_print(reg);
>   
>   	if (!is_ddr_dbe_triggered() && !is_ddr_hang_be4_rst) {
> -		if (reset_t == WARM_RESET) {
> -			debug("%s: DDR init is skipped\n", __func__);
> +		if (get_reset_type(reg) == POR_RESET) {
> +			debug("%s: DDR init is required\n", __func__);
>   			return true;
>   		}
>   
> -		if (reset_t == COLD_RESET) {
> +		if (get_reset_type(reg) == WARM_RESET) {
> +			debug("%s: DDR init is skipped\n", __func__);
> +			return false;
> +		}
> +
> +		if (get_reset_type(reg) == COLD_RESET) {
>   			if (is_ddr_retention_enabled(reg)) {
> -				debug("%s: DDR retention bit is set\n",
> -				      __func__);
> +				debug("%s: DDR retention bit is set\n", __func__);
>   				debug("%s: DDR init is skipped\n", __func__);
> -				return true;
> +				return false;
>   			}
>   		}
>   	}
>   
>   	debug("%s: DDR init is required\n", __func__);
> -	return false;
> +	return true;
>   }
>   
>   bool is_ddr_calibration_skipped(u32 reg, bool is_ddr_hang_be4_rst)
> @@ -2811,23 +2816,6 @@ static int ddr_post_config(struct ddr_handoff *handoff, bool *need_calibrate)
>   	return ret;
>   }
>   
> -void reset_type_debug_print(u32 boot_scratch_cold0_reg)
> -{
> -	switch (get_reset_type(boot_scratch_cold0_reg)) {
> -	case POR_RESET:
> -		debug("%s: POR is triggered\n", __func__);
> -		break;
> -	case WARM_RESET:
> -		debug("%s: Warm reset is triggered\n", __func__);
> -		break;
> -	case COLD_RESET:
> -		debug("%s: Cold reset is triggered\n", __func__);
> -		break;
> -	default:
> -		debug("%s: Invalid reset type\n", __func__);
> -	}
> -}
> -
>   int sdram_mmr_init_full(struct udevice *dev)
>   {
>   	u32 user_backup[2], user_backup_2nd[2];
> @@ -2860,7 +2848,7 @@ int sdram_mmr_init_full(struct udevice *dev)
>   	 */
>   	writel(SOC64_CRAM_PHY_BACKUP_SKIP_MAGIC, SOC64_OCRAM_PHY_BACKUP_BASE);
>   
> -	if (!is_ddr_init_skipped(reg, is_ddr_hang_be4_rst)) {
> +	if (is_ddr_init(is_ddr_hang_be4_rst)) {
>   		printf("SDRAM init in progress ...\n");
>   		ddr_init_inprogress(true);
>   


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong


