Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4274606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 02:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Mi+yW935;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=BSpRtfb5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5F396079A;
	Wed, 21 Oct 2026 02:29:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NDwGS22J43Ii; Wed, 21 Oct 2026 02:29:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DCE9B60754
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792549765;
	b=pH007SWAdIsyqfwcu4J0HkPSNSag7aXUt8GmxhzLnDzaSgyV1nQ13BEa1w4AcCFeWXY7
	 I3hD9NhBSFz4xYI12ixrB410suw33SEFb61XgqCI1cTup7LVl1sCjYPay3qQH/pQx+ALC
	 VKFoqiQW6+V4P58Ulruf+x8gqF2pLcksA9VEK0DHpmJ5rhRwmc0EXdsIgWB2RVD/DpoHk
	 W8lowpOHoTu+h5vGjDKvrF8ae/KosNViqpkR1rvLw2TE7x2x0Gbx2cGFX9iHNbhGoOfoZ
	 v+gpCImlAL6hb5ifvGqms6h4owNhlR/MQZuOBd5p17LW2tzR3DJi4f3C6vF2k2MAndQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792549765;
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
	bh=Uym9YZUgiMne6WJTxia1l3giDCfVY6BktMxVTp6adW8=;
	b=qCUXQO6aCgrXxbo4szpOuOfesVqWPhmVSpFZm03D7eHK4LWoW/z2U/FLx3A/HsRNacjc
	 Nj5RgA04cJZ5LsydirgxK40WluGwF/8zwOUDTJPHZQC9CcWIQx9//Kh6Okx056u3CvJkp
	 xp1dbnO6rAT/ZPdDL3WlNTNjMc5NGZUJ2O2dLPG9Qh9JBkNU5/01HXXgpsmx4j9w70DpG
	 XokzJ9SIl14YMLluYLbbExX1Z/3hyEhcWI37nfrOu2OUFFDnGnwAZ+OJl6iIYpbYk0vWq
	 iWE8qGwdzM5p8T4oWK7hesg4nsjASjUhFM+qCtC2ywkeZLvSMl0d1D4k/8G3pLnGcOA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792549765;
	bh=Uym9YZUgiMne6WJTxia1l3giDCfVY6BktMxVTp6adW8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mi+yW935Fk+muFuvNnBKYUgtyV2UW6KlapRa8qe0poCNyN8z0IugUjncMskgiEkeK
	 eET8BhAzznmEB1+mItoctwF5Ybn+++xiYM5zqWQ9yXywJzLqXjSnTDrvHSF8558iKs
	 Qzp5NVWiK0NkUUKPbGPGw27jN8tTXUjrUrrgDnTSOhOCC7xurX2eyfddpB9SL8XE4X
	 NyPNEDMvQ+nMYy+fcbmoRKfkXtFK+6AZ1HvBVUP/C4RnH7RPAXt2APxVSb9Bp97DtX
	 A72ysgu86AIb7Gxf8mB47dgevvOPCKE+I9SpLvKaqm9/EzS4uQ6A/P4U2HvNbbkSkX
	 TLovQIakHywSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCE9B60754;
	Wed, 21 Oct 2026 02:29:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DD9A2995
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:29:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF23A40112
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:29:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WVSNk8R87wF7 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 02:29:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F3EEF40060
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792549762;
 b=pWt/VW9/VHKdgOtO7WYGmmf3tL4/49SrPNZWSujLQkuNy90oC3gE2qUNN5ng1UC4YSu/
 rxJmYiFayagXEHYoM+yWD5KBsi6WBXtcAh2+ZnHFHFtOUOpChIKQqyDQYWJclea4GkMXU
 O0B+ZGdVLLOnQ7UQZCEwNmi5GBK3GYZBztuzemg93qH93Q+TG+eBPq/pW0Gw5zX0v61z0
 jmV8bWqS8IaHTii9PI93/H/5S9Rxf9FYOTPSb0ya+AC/EWCAYS0Cj8pe+ukzhMpFiBtOg
 mlcmsG56FaoI1pYCyRzuTwawJCfD498Hehep8IhHmvFre/Pg/T0LDBKt3FKIFbSroCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792549762;
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
 bh=Uym9YZUgiMne6WJTxia1l3giDCfVY6BktMxVTp6adW8=;
 b=mFsBFVcLcoXjV3bWKM5k303ZAaNFKcDA9OaPmWpHVmP2N9PjXEFdJb230baZw96asOwk
 nckMRwldQDdX7s/34+viwUZlbkX5dlez7agaKxAZkb+FUn0YjOi2CmHYrJ23b68kdA0QI
 TejE5ii1sJGrVJr9D+ow+ZdJ7/7mCM+cewbxGrbKzHW0tAZ7g7RTayTIxrV/L4xzJS69d
 ittvETidp8JBES+5r1xOrTEXDoUy4+9CPcihxGUoOhgmalusqLQAgF+w7Jrb7Fk0eBsA8
 eUfl/YEgWZ6aoh6H1b/6o0D4eOPbA2eaeMybvXAIa/JJLLXXQtpi7Ao6nDiT7gqzQwA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=BSpRtfb5; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=tien.fong.chee@altera.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=BSpRtfb5
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F3EEF40060
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:29:20 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3EB5844F6; Wed, 21 Oct 2026 04:29:18 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C33058056B
 for <u-boot@lists.denx.de>; Wed, 21 Oct 2026 04:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVb6UirhafG4mUhTb5/YC3Oihcki6Ms6GT2+yQb0UcXGj4O3LHzOBnsxqy81nOwZyWy4kSdf+dWjv7jSIGtfCabBbcpV2Vjregt4Xm5hOmApOBmlGCKggKYzKHD7kWUI7nuor5YkpNYQudXsqUi/IbevIXQLbWNpFQ3rzItrrxbM3J/KHjwsaTsPn22b74nnJ8ImYzIYz76n9cRI5QEus4IOkpXU1zsNzGnL7hJJq0g8/38S3GBm6m/0Gr/2dYPyjMulYKQTSLawIM3rAVG58di+OKIoRf4he7uxcQtt/y9myrXiD1HKbP77W4Hu+mvAb9TOajYZqJp3YdrFp1EPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uym9YZUgiMne6WJTxia1l3giDCfVY6BktMxVTp6adW8=;
 b=TIaFN4nJyDjjiNrsUdw27GJZbMtzw4Tp2AebajJhdCxn1w0o7hXXy2rcYv+BOHsHxEPRatE11uwPeCzPrpGPkvL7X5Qxjbvyrpczl5yNlFL73Gs3/L+f1M/+rJ+ye8FzPw+LOATjO2s3/rIzRikuna6QZFeFPVeacGP91PiVRfjKvpzcNYrjw6fRy5iAdUzy1wL3Sv4ntuSLj7OgBWGaonnd2RWlWwIC2F1FRPEDsRswOnJNMsIibfVbmIPap4rjwZu3xsFrA1pO781QcRxVT1J9yVKjpSk3epChF3LuWkYb0b3RFZfM9A1Y7j2LcGx8uagpC3Cf+PaKZKbX90/MVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uym9YZUgiMne6WJTxia1l3giDCfVY6BktMxVTp6adW8=;
 b=BSpRtfb5na+bpCTsbYhXd3sjnBj+4COueHDBdyxZpCB8qEnMX3O995zpnLmTd72gIrr4XdTQfRr5EnKrGBFadurXdGjJYnjIXX9fzOEOHxZjFiBG0WQSZFqE2aj0wKWAgcVsrnAAg9ZSNvSbjWk8Rb79lAfQ5M2TijUTgZZohVbiOL3h4x+2ote+iWYaORzS7QK26YIaWkydIzGqJPPw4qjZmm0fJvjwpIlPljmXq7vviVeFvppl7qQ6ow7A8AezoPBC+XbsAAdH6O6UQwaF0x7b6iuACjsw499zht44vcHYLK0h5gHHOIJ4NBtIb54IWwlAl360mQKIlb8K7QuOCA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14) by IA5PR03MB989654.namprd03.prod.outlook.com
 (2603:10b6:208:608::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 02:29:08 +0000
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d]) by CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 02:29:07 +0000
Message-ID: <cfc6573d-b591-4683-8655-8c1e206951ab@altera.com>
Date: Wed, 21 Oct 2026 10:29:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] ddr: altera: n5x: drop always-false unsigned
 less-than-zero checks
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20261016044047.21496-1-chen.huei.lok@altera.com>
 <20261016044047.21496-14-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20261016044047.21496-14-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR03MB959535:EE_|IA5PR03MB989654:EE_
X-MS-Office365-Filtering-Correlation-Id: df56e825-3b47-4c49-9a3a-08df2f1b1554
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|55112099003|13003099007;
X-Microsoft-Antispam-Message-Info: icm6nqtdsFpsNgBYfXmF50u4ccAYD1T/HRaF3MXqqe9i3bbbNbiWmleH+hs7yYtXtGhv+u/hQClJkaHPX00zV9ox/jCzkuMG5k5Ydc/JhrDj8LR4vcOYf7x36e21DIFOtEYXGHQfW2GALsYMQYDV5uT8ipWkk+/gSzOldpd4E658j0FBqsxee5SEL/d2pWBL2T7JovNMw7FrlcvUJLvbsfYSLMiS4iuZ5FpyKGIyXCunI1IitrUciOWGZ2nvw0OTtjz1P6GSaiNrHo/6YrfJhaMRxB5hKu+P7ysT5MIFEFDJwbqZo91ezjPcZ/M1P6s9XxIUBxT79SYkSUSjLQnLc4c3PyVbrBh3ZQG0ar3HBTmEpbR4q4qExeI40aFA2s0IVHUonGI5Ls75hK4ez5/9uB2DovLelPpusIJYSRxrKzIZxS9D+RLk0E+q6IsQmd25VH59aW2bEYcty6RQOb46tdL7i7WVIomD+WGK1IgBBMVon64keVcG7VBpnsYpXynIOZ+4/3TjHQ64RJYN/21Rjo3yLO0Oq19xeDnTnxpHLr2d50gmCAiFUgVmHJUF+EckcxWp0fMbqCA0bYgvfiabIYMOO006+4POaE1P8ppcwTM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR03MB959535.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(55112099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkNSNHo5WmIvNTVtenVhWHg5WjU4VUE0U0hzeStnZFVWWldhakpwVTN4cG42?=
 =?utf-8?B?bWh4dURqZmFScTE1TnpHSWxybGF4eGtDZFBPQTUvQzJwWUgzd0syUlhrc0VP?=
 =?utf-8?B?UlhvT1V4NHlWRXg1VWxUMEtTY3NRZ2lhYnJTbHlsc3p5NG12RldmbjBQRlFm?=
 =?utf-8?B?akd4bjBSKzZFMk1FbGoyV3NSNzNDTEpmaHFPbzBFRWJLZzcraXM5Yk96d29R?=
 =?utf-8?B?UjZIS2pNMFBadWh4Qmd5dStUWTFudlBKck4xTDYvaTFsLzZuZzdmUUptK1lk?=
 =?utf-8?B?Rk5WOE9IU2ltWmh1cEU0Z3dDcFY5UWVsdHl4c081MFA5TFk1dlU4UjR2NEVQ?=
 =?utf-8?B?a2YxWkVjNWtmMllETXU4S0tIRzZxb2lTVzA0QStUZlR4dFIvR3ArblZqMU5v?=
 =?utf-8?B?eGgra2g0SWRsOUdJV0ZTMGkyNFhBVGJVWDBQVGxOQnFmc0xSbkcvQlQwWjk2?=
 =?utf-8?B?SVpoaVQ0SnNLYWhhSGY4UHRuOXJQK2VvaDJrM21zVkJWVS85ZThmS2pTdGJO?=
 =?utf-8?B?SVdNTUlCWWRKSERzWDB6cFg0YktkWGVoZ3JsaEN5QTRvMVRJLy9XWXVDWE5T?=
 =?utf-8?B?NjJMQlBDRyszbjhuQ21INUNFb3h5aUJyaHNaVkl4Y0NTai95V1d6ZXdVWGlQ?=
 =?utf-8?B?Sk5hVVNNbG1YOW8yRWtjVThKdXhxb2pDWEU5aW5TZ2lKMlVMT3FkVVE4Mm1P?=
 =?utf-8?B?TjhuZkxMclFydExjM1M3TGgyQjNKdnViditvMlFDdnhqclZnM1J4RXk0cC9Q?=
 =?utf-8?B?aHBIbVUybHZPYXhjUENmRHVKZ2Y1bkI2eGM5QkF1d0xtL3lkYlc5SlBLNC94?=
 =?utf-8?B?QXhkR2h4bkkvWG9NVnl4WkVrOXFnbEJuL1ppeWJvQXlOa1ozOWl4cXdUcXps?=
 =?utf-8?B?WVROVkdxMU4wcU1OVTV4KysyUTRlaE9FejIrU3hJODc2WmN0ZkVvaVVMQ1d3?=
 =?utf-8?B?Sms4OGhzUjNkZzZVZFZ1eTJVcjhnSUh6dkMrZk9xVGdzQmxJcmhkUm0wMXpI?=
 =?utf-8?B?UVVLZkw3bTd2b0lDZTNpOGxLdUhKd3E5Z0xycjltVWVqNENINnNzYVZ1bUVJ?=
 =?utf-8?B?YnhTWTA4L0lsUmcyc3E1WE9ERU94WWFtYS9HMTZ6bmtuQ3BRazZzNFczSVZI?=
 =?utf-8?B?bEhVRlJhVkpMQ09zM0lidm1tV25ubWJyejN2LzYzdVF4T0JjeXd3L1pic1FZ?=
 =?utf-8?B?UWJaYnpRa0t6WHZnM1BWdGQ4UkN5UmN3bDhqSTRzenhSb2wzUFVvSi94S2Ry?=
 =?utf-8?B?R0hPVGttRS9RQTV0TEVhNzRDUTlTcG5lT0NMbTBlME5zdnY4NVYyUEN6NzEx?=
 =?utf-8?B?UW9jVnRGTlR2WHJtNjJsb2I4SmVGbGhuRzlaUzhtYjcrVm9JVlVRTFg3NVRK?=
 =?utf-8?B?M2RrSU1rTk8rSjJqeEdhVlZrYWM2YWdLNFRDb0xoRFFGNnpGc0xtUTM0amFK?=
 =?utf-8?B?aGl2RGJpOTFSTEE0Um12WUJBOFVIREc1c3JUdmRkQjM4OTNWYml4S3pONkN4?=
 =?utf-8?B?TTlwOGE2cGJlci8wdVNlL2JkUm5KZTZQZVExVFhpVnNZVlpCcGIrWHNsQVlq?=
 =?utf-8?B?TEJEc09CK1RvWlZsa2QvMGYwaHFXVlFCWmtlSE1vL2lLVWlvaVBPUEtzMng4?=
 =?utf-8?B?TjhQU1FSMStYajRvbXNhbGxIb3pKWjR0TVJGVEhXcG1vMEhqaDBSTTNIZlor?=
 =?utf-8?B?NUl0WTJla3VFaTliU2RTd05NaGF3L0xsbFRMTnZvTXd5QURoU3lrNWVjemlS?=
 =?utf-8?B?NWk1Z29nNjVERVI1THN3elFNZXpZTTdUVG5sVzNpQXBBY1ZlVCtKSG9OaHJt?=
 =?utf-8?B?VENwNUVvV1doL084eHRTRTZQZDdxYzREMnBMQkp4dCtpVmRVYmJXcjBpSlYr?=
 =?utf-8?B?ZTB2ajlab0hvMGxTYk52YUZMa3I0WUxwVzBBalhJMiswcFB3SGpLd3Z1azJO?=
 =?utf-8?B?djR3THJnSE1tZHhNWjBSSzZXZVdmakdHcUJlSU9iK0lYTDkwUG5wYXB3K3pt?=
 =?utf-8?B?UHZrWTlDVHlhRzBCMSszdUk0RDROQ2JDVnp4UjY4TUlqbnRiM0dZWTlyOHNW?=
 =?utf-8?B?L3VlQVJnN2lPQ2ovTktLZHo0d0h2VlZIeWJMdVNkOXNJRFhHTCs5SEdpM1Rr?=
 =?utf-8?B?elpyYW9ZM1JOMlJnVUViM21hUXJOQlJHb3B6aG5CZ0dUZWZMOUNXZURjaGhj?=
 =?utf-8?B?VCtGYysxWFlhV3RFK054eVFVYTNzVmhqTFBVbXk5Y3R0N3VxWkxQL1ZBelA4?=
 =?utf-8?B?bjJqUm9lZTd2c1phYzBqTllRdnZ4d1hjang1YWlpamU1cHgyZGZJQ01HV0d6?=
 =?utf-8?B?aHYxaXZCOVNUUUprdnBXemJFVDV2a29GaUtTelAvUG42VXNCbTFFa1dtaEVF?=
 =?utf-8?Q?ogufQcbVsxoCBw3Y=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df56e825-3b47-4c49-9a3a-08df2f1b1554
X-MS-Exchange-CrossTenant-AuthSource: CHBPR03MB959535.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:29:07.8979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7M0Qk4zGRkDgAuq++5PV77RMDkghV5QCZIBUHpz1lcsLepHbmZktYSU3LZAnQieDBlhvBGbPzvSI3QMKZ1r7KxyloZnx7RcmoUXpjYVkTes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR03MB989654
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 16/10/2026 12:40 pm, Chen Huei Lok wrote:
> The *_handoff_length fields are unsigned, so the "< 0" checks on them in
> populate_ddr_handoff() can never be true. Remove these dead comparisons.
>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>   drivers/ddr/altera/sdram_n5x.c | 32 ++++++--------------------------
>   1 file changed, 6 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
> index be512cd33b1..558415d7931 100644
> --- a/drivers/ddr/altera/sdram_n5x.c
> +++ b/drivers/ddr/altera/sdram_n5x.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>   /*
> - * Copyright (C) 2020-2022 Intel Corporation <www.intel.com>
> + * Copyright (C) 2020-2023 Intel Corporation <www.intel.com>
>    *
>    */
>   
> @@ -1731,12 +1731,6 @@ int populate_ddr_handoff(struct ddr_handoff *handoff)
>   	debug("%s: Umctl2 handoff length in word(32-bit) = 0x%x\n", __func__,
>   	      (u32)handoff->cntlr_handoff_length);
>   
> -	/* Wrong format on user setting data */
> -	if (handoff->cntlr_handoff_length < 0) {
> -		debug("%s: Wrong format on user setting data\n", __func__);
> -		return -ENOEXEC;
> -	}
> -
>   	/* Get the next handoff section address */
>   	next_section_header = handoff->cntlr_handoff_base +
>   				handoff->cntlr_total_length;
> @@ -1789,13 +1783,6 @@ int populate_ddr_handoff(struct ddr_handoff *handoff)
>   		      __func__,
>   		     (u32)handoff->cntlr2_handoff_length);
>   
> -		/* Wrong format on user setting data */
> -		if (handoff->cntlr2_handoff_length < 0) {
> -			debug("%s: Wrong format on umctl2 user setting data\n",
> -			      __func__);
> -			return -ENOEXEC;
> -		}
> -
>   		/* Get the next handoff section address */
>   		next_section_header = handoff->cntlr2_handoff_base +
>   					handoff->cntlr2_total_length;
> @@ -1831,13 +1818,6 @@ int populate_ddr_handoff(struct ddr_handoff *handoff)
>   		debug("%s: PHY handoff length in word(32-bit) = 0x%x\n",
>   		      __func__, (u32)handoff->phy_handoff_length);
>   
> -		/* Wrong format on PHY user setting data */
> -		if (handoff->phy_handoff_length < 0) {
> -			debug("%s: Wrong format on PHY user setting data\n",
> -			      __func__);
> -			return -ENOEXEC;
> -		}
> -
>   		/* Get the next handoff section address */
>   		next_section_header = handoff->phy_handoff_base +
>   					handoff->phy_total_length;
> @@ -1875,11 +1855,11 @@ int populate_ddr_handoff(struct ddr_handoff *handoff)
>   		debug("%s: PHY engine handoff length in word(32-bit) = 0x%x\n",
>   		      __func__, (u32)handoff->phy_engine_handoff_length);
>   
> -		/* Wrong format on PHY init engine setting data */
> -		if (handoff->phy_engine_handoff_length < 0) {
> -			debug("%s: Wrong format on PHY init engine ",
> -			      __func__);
> -			debug("user setting data\n");
> +		/* Checking DDR handoff is overflow? */
> +		if (SOC64_OCRAM_PHY_BACKUP_BASE <=
> +		    (handoff->phy_engine_handoff_base +
> +		    handoff->phy_engine_total_length)) {
> +			printf("%s: DDR handoff is overflow\n ", __func__);
>   			return -ENOEXEC;
>   		}
>   


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

