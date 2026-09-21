Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274FCC982DA
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 04:32:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6C9D80A98;
	Mon, 21 Sep 2026 04:32:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dW5PL2CmB-TR; Mon, 21 Sep 2026 04:32:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A570080996
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789965177;
	b=o66dKRrXW3vMK6XSUVF1dWzx4KSkPGBXtp4rmToFER9BQ1ezBl1jvfHVvysQpyfn25H5
	 /XzeY6gKu2EgapUMD2Xk6p4fdZWZhBNzTgrIi3bzI2K1QVveQ312G8ypyFMXC2WIKsy9d
	 GGAF9VRAoCONHKYkGpJLAWDP1+hRqnaATC/+qIDynYLG4RJX3MGGRjN/5ihVNqj3kG/q5
	 w+GT1nIP3xqKiWmlkQNshBtCKB2YdEOZOP4dll08IanMNf/BVbMpUvA0a8nYgjpWreZpX
	 o2xWuOuIA0sgSUe7qHi1SxGg8ciMf/GezTdjYRC3S/LjptU7S+PbF+3IIGBudGAzHkA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789965177;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Content-Type:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=067X6E1jnNYpwxC+gdFHwFmy/Mt6Nz2VG5f5xl8UbnI=;
	b=dPLKpo5Ffl5zJPXzxkXv0k3x7Xy5cROMMbu/N3MKAjSzo9hDRTXV8QohI1UZQuWi3VbL
	 h/BbfEAzCthsORe8Rnn5VRbEWaxLlgNZbKe1G+oK1XsiCrMqtlWpWN7OochsXqOwy1XaK
	 7ADiwLcE94PP+PKyz6Z7i9wwGWbsQtiBQq6gM0mOYFo0BtTZU+URYPKXn3FuUTHpLp0ek
	 DaHg8xPXF402wNyFGXBfMDCrPe97fcptdG8QrRBclbN3UVvOQmADauJV7v9FDZcHeuqww
	 03jSxWspnzuJCP2Ljfv5AwrK/IW/DRO0XUw6IgujoC/8x67gnq/yCuU0jd/ixFrVC+A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b="Wc/f0oMs";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789965177;
	bh=067X6E1jnNYpwxC+gdFHwFmy/Mt6Nz2VG5f5xl8UbnI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WZYIuA4Z23ZD72KwCUo11Met2spoe18/s3CCWEGsnwuwBw9TMM5A6n2fDMw5K0bYo
	 Dxp/iSUvX6DrO6J/xqJ05YbGt9t5OJqguFZUpdgaPIhd2EiamXlFsMbQvb8LERrUza
	 s5acc34E9mXFXwsvXw2+6ErJ5BqVCZ4AH6VsUvRiGv7OKJSw8VS33JnoC/MQQyL2XX
	 3bNYKyBuYFDD9q8ztbgXgiYW2+ck8hbJCSlLFNiWw2hlHKsvqo/RQK/GwWiwdlcbnG
	 Op9SmdVECYUvZ0vsfaE1ZEZyeS0hOt/ydHTzxu0GaeV6y3nQTghziEig9/5a/4UKHA
	 3XzbrXM2mB7Cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A570080996;
	Mon, 21 Sep 2026 04:32:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0225028C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:32:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DC01F80980
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:32:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VjGo4lwe1zqN for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 04:32:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4974E8098C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789965175;
 b=hgkyNcDKLxgPrmiR7b0oLsdVAZTir6WVNlJ/MwDmiXVR/0C/npxeF06qZu00iJQ5vUj5
 qutEHzwBZ99Xk2GheGmflguY83UhdlEMHMjFPApmxBQVUPXMfESDI+MMz9V8cvVV3St2c
 NCWUb+C1Ars59sOyOHYVKEd2TOpt3L8i6AK/3cXVpKYrOul0SX9MclRHBxaS1PSWK8kVZ
 RiLVdMTp9xe1AkPurDkTMzLTB6DdztYPKKhrT1XnVdtroM3epg3vHiJzwVQGC7OmruMa2
 LxTeqkzQmil509kcQmMer9dtVOgkdHfyMxV1F7jtoEME+WRXTTfPZ/aHUs/kG43/HWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789965175;
 h=Received-SPF:DKIM-Signature:Received:Received:Content-Type:
 Message-ID:Date:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=067X6E1jnNYpwxC+gdFHwFmy/Mt6Nz2VG5f5xl8UbnI=;
 b=Ghz97X2VK6z8meq1W3nNvkW8DwdbOBCkZHMtGsO+rxuaG5g8p9LVYS/sIL97/5xZZTl/
 mcRiANEOpI4YZi88GDwg7Hjy5UkPEB0co009EsDp+Pmk3k46m9gO9iiNm9hf6OxLxS9nf
 dKw5iEa2sMgZtfhJR/q2L9i79u6rpJih/yT2TtZK0x4MP8uRBkBDRqV+CzEapfKRvvEfV
 uEMwO5zS/K41OKvQZV2ZvlfhFk6DpcemBcssMpUiVML0Y+qTJpC53Dni74fXwLMj4+g1A
 fXeZeKThXra457UqhrtZXj+f8EU+v9VgFsoTYKuz4HLRzrvqtUAH9iBBYcv+zS8AfnQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b="Wc/f0oMs"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10d::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::3;
 helo=sn4pr0501cu005.outbound.protection.outlook.com;
 envelope-from=tien.fong.chee@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=Wc/f0oMs
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4974E8098C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:32:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIZqWf58pqkwptBRBlNcVze91QWjHEgPe789Icc4HUTMprrax/2NoF7ZtQPpguQB8usd3yKKmL4h9GYNlne3GSSHHbk6WS1imGh/8BPlxbOZrwNS1w51vtbb0ZW+9uh2mo0GmRYBXZO/AY23klCVdKJ6ktNjH0uKuc0XoCop4LebJcBwBEtfqSdt+7uB+rB6HD0FEKkwSEn1p82cVHr96qQpvcTdIsKFA0TvqomxCT4OYHgx9I/xeGyD2tCbax/P008mu3tX4hA6pyOILLOuQVl7xtWxUTcvMe/7DIn4mxPfpxTILocwKA6z44StnFTm9hoMSJwORc6MATW+5fhLUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=067X6E1jnNYpwxC+gdFHwFmy/Mt6Nz2VG5f5xl8UbnI=;
 b=dNxrJ+dZew14UiOfFroKntoXul8l7vH8ruDoUM0rOdoeS4fGwzQ9uwcdtovo3oo2GX+dCN0IxCyNjTkYTAwWDUOd7ZY6Qfd3Fny0eZVj2K+i9Ig7QJbHOU18gzUQ2JWM+cq2JpKQq/Z2yYoXVBNDFYCGp6NeFtnRUlHpHZCywtady3w65zCE5Hje6XaTY1V1s7B61grZD9ZJgmh774uFY+iEBsMU7Cu57F+mILiVoeSJb34i2aYv7nQr6x0j1VOJ7gtFPon3xXoCCWtrkoiFH4/rexqCFrX8KM//S2GfRwHm69Z0u1nj3z/ByOmUDg2ffuwjfJre6RXky2dxOWu79w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=067X6E1jnNYpwxC+gdFHwFmy/Mt6Nz2VG5f5xl8UbnI=;
 b=Wc/f0oMsj4M5WZT8BZCbvs/+5ESoLLhP/itwWMlkqlWw0lm86AiN9YBa8ySy9GVFl4K3ZH1CUkL4CHRWQl0gz8VNvVuhRXoDx+QFbfANmvS5iNtyEqDl/i8j6lP3zI7QPK1b3y0W9R8BbqanIj7LzFwnSd2iKvueo/+ADJ97F6dP/nCXPezr4fULKKPk1m+7t64WsiZjJYsdeLxpswqtqf9M7bHpyjrjnM39SBPPhs7jdS/K/SgBKKJu6MQ4vorBOPjSd3t3ZV9RnORIAtaGXDClbrUym1CM3NK6Q7TVMXKS2v/5NsL9hXE31HZdkS60nVKbdc3LoQia9yUUv4hG4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB8229.namprd03.prod.outlook.com (2603:10b6:806:465::17)
 by CH2PR03MB5318.namprd03.prod.outlook.com (2603:10b6:610:9d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 04:32:47 +0000
Received: from SA3PR03MB8229.namprd03.prod.outlook.com
 ([fe80::2802:a21d:f4ad:97]) by SA3PR03MB8229.namprd03.prod.outlook.com
 ([fe80::2802:a21d:f4ad:97%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 04:32:47 +0000
Content-Type: multipart/alternative;
 boundary="------------76KaDSnEmWCkHOoLssBtGF95"
Message-ID: <ad3f2380-8ec2-4ea9-9cc2-f4551919be70@altera.com>
Date: Mon, 21 Sep 2026 12:32:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update some SoCFPGA related addresses
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>
References: <20260914210444.638315-1-trini@konsulko.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260914210444.638315-1-trini@konsulko.com>
X-ClientProxiedBy: SJ0PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::33) To SA3PR03MB8229.namprd03.prod.outlook.com
 (2603:10b6:806:465::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB8229:EE_|CH2PR03MB5318:EE_
X-MS-Office365-Filtering-Correlation-Id: 0644266c-c834-48b8-0c1a-08df1799631f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|55112099003|56012099006|11063799006|8096899003|10067099003;
X-Microsoft-Antispam-Message-Info: OWtb6GD7n/ez9qXW2TAnHMdBrabrJRo6tCOl53z44jX+YVMlqJ5bdLpJdlDDSqE9QEWaHr1/tt7XzcUTl2Aef0vA4OHHm1539LLJ5SS9+mC3/Zwl7UpDOKiwNV017Y2u1/IvEjPs2ah2F1SptkRbwSXOzZye03DEiju9DMUMmXZ8fL80cwgNQeKEtUD0SAC7+NApfx7G1OYzbueQ6uEZbvoRjpyFx9CkSykDs+nHPcOiEzDYr3aCWH+e+IKS+jKX6zwx08cmel7hun3z7Lb/u2vrGvYRsJD0ex9tI/uDR3yOcfZ85TvfrJKqBGQoDcuW7cEwklpfYswshKndWsGwqLH43UfcZt3TpOUw/jXISibz63T5BZBzBwbtkoGlMLP8ULr6leOoKfTqZTrxnIGAPlT30NrB/0CwXAfvBC00C9DK1mcZsU60efjkbKo2o23NbSpXTPd2H3esCxGN5I4EmBImyOY0R8xo/Du8gvjXBOcxMJGHQfkhCfeaYpWgBB3uv0i/x3XyEOQddnG9hRstcsTBZ2pQeSHFzzIdI6Uh64IzVky/52pjMH4vdMejXCXUJs6SanaFeV1F47hwZDXtUl28BzT1w+7lcVTQAbmLfLIgj1bOq1/t25FRxAxOVCKqQepSuvqNuM3+fAAuiwEdZRkkNgGxPVRZtoqyO37FlZA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB8229.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(55112099003)(56012099006)(11063799006)(8096899003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjRzUG52NVBVLzVESjhKdDlyKzMrbHZKWWs4NDFGMWY0a0JFMjV0NVZ6Qjk1?=
 =?utf-8?B?Ym9VSjdZNFQxZEU5SSs1ZXBLSFlUVkpQdTNCcVZReUFsN3BDU1ZBRlg2YjBO?=
 =?utf-8?B?S0htRUk1TUFJRllJOUFKaXlEbjNmSEtMOXZGczdDdTV4NmVIbkU4bUlnQ01x?=
 =?utf-8?B?Mm9UMVJyLzJqbWxLVHE4Wmk2T1VhZG5wMG9hR3QyWXFuM252MTlCOXl6SUd3?=
 =?utf-8?B?R3p2N25xR3M4UHlsYXZmenNmVE1IVnQ5amEwZ2pybjF3SGF0cjBReTBYSGNm?=
 =?utf-8?B?NXN3SndFZ2lpa1ZGQmRiUXR3UU8rNHNUek9ySDFYMzBZMnp6dFdtSExrNEdH?=
 =?utf-8?B?WVl0UGt3TDVEeUFrd2JONlFLT1NHSVMwVnlqb1haK0YwR3ZEQ01LMkY3Y043?=
 =?utf-8?B?L0p4U0U2UEMrOEFrQ1dzUGlnczk4Q3QyZ3NCQ09zSWRzRGZsb1JLOVlqQmpi?=
 =?utf-8?B?OTNncC9BSkVHVUpnM2xFQVEwWEpLMWFxKzFBWHhjbU51RHdQRWNvdndEbUNJ?=
 =?utf-8?B?KysrRzFZRTFBbTN3UGd4N2hsRGZTdXBxNkVyYldKY3hFOEhJUjNmRG9uS05G?=
 =?utf-8?B?REhKRCtsdVY1VFdXK1RSN0o2YmJhVTVPaDBiY0JoNzBJbWwxejVBdmFFYjli?=
 =?utf-8?B?SHV5RDFYT0dGMmxYMk8wZTRSQnJPYnN3R2tZSXBGbUxQYWpIM3gveERyeFNL?=
 =?utf-8?B?NnowMTBFdEI5Q21rVTRaUzI5Tms1NlN6UGEwMjIrTHcxalBKVENxcUQxcDFz?=
 =?utf-8?B?RU13YnNsT0lObFRaOUVtUGkxVk91TFBwcTZTYW9kRkQySXNOWDBVbklQWHhN?=
 =?utf-8?B?THZYR1Z4cDl0Z0RXNEo3ZGQ0QklDS1ByM1NzVkQyMFh6OG96RWhFOWlSNFhE?=
 =?utf-8?B?SHFiS3FQbStldmVzb1FTRlRscVB6YlVvcHRKVm5TQ1paKzFCamJya3YxRUZ5?=
 =?utf-8?B?alVuVWFkV0NlTjlLK0VXQ0VDejNMTGhOVTdPQlc3VVV3WmVFaVhmeDFMdXZ3?=
 =?utf-8?B?RGduUUY1SE1xcjJwNUxNTUZKMERrNE5yR3hhdHRqdEZMbTB2dmo4ZlMrWmhQ?=
 =?utf-8?B?VVRZSDBFcDFaQjhqZm84eUE4aTNWZ2RCVW9HVnRNc1NGMGJ4Y1VpUE4vS3Zv?=
 =?utf-8?B?cWEySTI2dFFIWGpCUnI5aVhqRmJEVWFZOGhpYjUwdFRhMHJqdXVQU0xBVGZ6?=
 =?utf-8?B?K3FES2ZQOC9Rbm1HNXBxVlJHZE1mZGU1WDBnWU9tL1VnUW9TdU9tMC8vS3dw?=
 =?utf-8?B?V1BobHp1MUtYRmRaSGh6MmhCVXkvamF0VE9ZNlNNNkNUaGoyM3Q5TnVyRUU1?=
 =?utf-8?B?VTlYbkFQcnRwQzc1ZGhUVDFucGhzSlVZYmNFN090L3dXQzZ5eWIzSnRVbXIz?=
 =?utf-8?B?R3p4Rkx1ZEhPdEhJNHpzS3JZSmpXRU5ZNGl2ZXJJclF3dStVRWRFQ1B3blAv?=
 =?utf-8?B?L0crUVhkbkJBOVl2TXZnQmwxRzF2RFhpbytZaEtrSjVPbzNaNzVHTHUrWmFk?=
 =?utf-8?B?TEZRKzlqNVdNa216K1JtazRGL2JjR0g3UHR5L2tRMW9UUHcxc1IwQktvbmFT?=
 =?utf-8?B?OU1GVnBqdVJCdks2SjZObWI2KzlpTEtyOTNzd2pldGI4dzgwbFFTZW02Qzhu?=
 =?utf-8?B?bjNuTXkrTFljbXBvcDVpT3ZUaGpycm9BMVlVU09IT0hscjgyRlZFQXg1cXFX?=
 =?utf-8?B?M21oL0dOc2o1dHVKOHBITXhodDF4ZU5kRXNjUFlVcTNySDFOY3Zac2NwNHdT?=
 =?utf-8?B?bkdvL1F1V2hLeVdvTFB4R3ZNQmdESzM1TVkyeGFEQVRzUVFaM1hhUzVFV3dU?=
 =?utf-8?B?ZG9GTTdtYVl6ZDdJQnY0TWJlZ21EL1VoTWR3a0lNY1JYNXdJSjUyQzRScXd3?=
 =?utf-8?B?UWFWZzhwVzN5cllDUHd4dnV0cXNRakZTQitxeG9oc0hsM24rWGJ6cFB1S3V1?=
 =?utf-8?B?R2dEZkVzRmVHbldvckVoSnFwRVQ3VHpRYklSSmduQi9rYmpDbjZwOGlsajEz?=
 =?utf-8?B?M2JhTE1vVmM5S0pIQXJSaWoyNHY3QVgxUzJDVm1mYnIvVWxMdFFMM29qUVBi?=
 =?utf-8?B?WTNhOGZxcE5CYm53ZkdzS0RKOHBuKyt3aFBoK2RYd3N3K05OZCttN1ZJU1pt?=
 =?utf-8?B?MkpQV1htd0FoZHpBZENCUmJYWnNFWGZ2aWhGNENVdXI5ZUowSXhFSld1eXZz?=
 =?utf-8?B?V28xVlhZZFJsUUJETmVpUEZNSUhFejI2WllnODVTbmQyVGhZamhqeFdOVVll?=
 =?utf-8?B?NFdjMUZMVVhPQ2J1RVVZYWx6ZUhDSTlrbnBXeks3WmlleklxV1dyNHBsRXc2?=
 =?utf-8?B?UExnTktHdnVYejRtcmthRFYzWTVLOGdaWlUvUlZ2dDZIbmlPS1BJQT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0644266c-c834-48b8-0c1a-08df1799631f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB8229.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 04:32:47.0818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrhJcG5okeQTChPsep42fgFYqGMIVyeSNtbycrneFsOfz/6YqmCVWQ8q80Hl/DMeDLPnzq4K+RwsnvI7cal5wtbyOQLZykUxRgznXtqZSos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5318
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

--------------76KaDSnEmWCkHOoLssBtGF95
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tom,


On 15/9/2026 5:04 am, Tom Rini wrote:
> With Altera no longer being part of Intel, some of the email addresses
> for the maintainers for these platforms had not been updated. Update
> these to match more recent patches.
>
> Reported-by: Michal Simek<michal.simek@amd.com>
> Signed-off-by: Tom Rini<trini@konsulko.com>
> ---
> Tien Fong,
>
> Can you please audit the MAINTAINERS files? There's still a number of
> other Intel addresses and it's unclear to me if those people still work
> on these platforms or not and what their address is. Thanks!


Thanks for the cleanup.

The updates in this patch look correct to me. I'll also do a broader 
audit of the remaining Intel email addresses in MAINTAINERS and submit 
follow-up fixes where needed.

> ---
>   board/altera/stratix10-socdk/MAINTAINERS | 2 +-
>   board/intel/agilex5-socdk/MAINTAINERS    | 4 ++--
>   board/intel/n5x-socdk/MAINTAINERS        | 2 +-
>   doc/git-mailrc                           | 2 +-
>   4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/board/altera/stratix10-socdk/MAINTAINERS b/board/altera/stratix10-socdk/MAINTAINERS
> index 6efd0cfc0560..d1a040977c15 100644
> --- a/board/altera/stratix10-socdk/MAINTAINERS
> +++ b/board/altera/stratix10-socdk/MAINTAINERS
> @@ -1,6 +1,6 @@
>   SOCFPGA BOARD
>   M:	Chin-Liang See<chin.liang.see@intel.com>
> -M:	Dinh Nguyen<dinh.nguyen@intel.com>
> +M:	Dinh Nguyen<dinguyen@kernel.org>
>   S:	Maintained
>   F:	board/altera/stratix10-socdk/
>   F:	include/configs/socfpga_stratix10_socdk.h
> diff --git a/board/intel/agilex5-socdk/MAINTAINERS b/board/intel/agilex5-socdk/MAINTAINERS
> index 30d8815d2020..4a52891e015d 100644
> --- a/board/intel/agilex5-socdk/MAINTAINERS
> +++ b/board/intel/agilex5-socdk/MAINTAINERS
> @@ -1,8 +1,8 @@
>   SOCFPGA BOARD
> -M:	Tien Fong Chee<tien.fong.chee@intel.com>
> +M:	Tien Fong Chee<tien.fong.chee@altera.com>
>   M:	Teik Heng Chong<teik.heng.chong@intel.com>
>   M:	Jit Loon Lim<jit.loon.lim@intel.com>
> -M:	Dinesh Maniyam<dinesh.maniyam@intel.com>
> +M:	Dinesh Maniyam<dinesh.maniyam@altera.com>
>   S:	Maintained
>   F:	board/intel/agilex5-socdk/
>   F:	include/configs/socfpga_agilex5_socdk.h
> diff --git a/board/intel/n5x-socdk/MAINTAINERS b/board/intel/n5x-socdk/MAINTAINERS
> index ca063a9f3f1d..15ba9de17e05 100644
> --- a/board/intel/n5x-socdk/MAINTAINERS
> +++ b/board/intel/n5x-socdk/MAINTAINERS
> @@ -1,5 +1,5 @@
>   SOCFPGA BOARD
> -M:	Chee Tien Fong<tien.fong.chee@intel.com>
> +M:	Tien Fong Chee<tien.fong.chee@altera.com>
>   M:	Lim Siew Chin<elly.siew.chin.lim@intel.com>
>   S:	Maintained
>   F:	board/intel/n5x-socdk/
> diff --git a/doc/git-mailrc b/doc/git-mailrc
> index 5a78376aa776..9ca01f59cf30 100644
> --- a/doc/git-mailrc
> +++ b/doc/git-mailrc
> @@ -47,7 +47,7 @@ alias simongoldschmidt Simon Goldschmidt<simon.k.r.goldschmidt@gmail.com>
>   alias sjg            Simon Glass<sjg@chromium.org>
>   alias smcnutt        Scott McNutt<smcnutt@psyent.com>
>   alias stroese        Stefan Roese<stefan.roese@mailbox.org>
> -alias tienfong       Tien Fong Chee<tien.fong.chee@intel.com>
> +alias tienfong       Tien Fong Chee<tien.fong.chee@altera.com>
>   alias trini          Tom Rini<trini@konsulko.com>
>   alias wd             Wolfgang Denk<wd@denx.de>
>   alias priyankajain   Priyanka Jain<priyanka.jain@nxp.com>


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

--------------76KaDSnEmWCkHOoLssBtGF95
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Tom,</p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 15/9/2026 5:04 am, Tom Rini wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260914210444.638315-1-trini@konsulko.com">
      <pre wrap="" class="moz-quote-pre">With Altera no longer being part of Intel, some of the email addresses
for the maintainers for these platforms had not been updated. Update
these to match more recent patches.

Reported-by: Michal Simek <a class="moz-txt-link-rfc2396E" href="mailto:michal.simek@amd.com">&lt;michal.simek@amd.com&gt;</a>
Signed-off-by: Tom Rini <a class="moz-txt-link-rfc2396E" href="mailto:trini@konsulko.com">&lt;trini@konsulko.com&gt;</a>
---
Tien Fong,

Can you please audit the MAINTAINERS files? There's still a number of
other Intel addresses and it's unclear to me if those people still work
on these platforms or not and what their address is. Thanks!</pre>
    </blockquote>
    <p>
      <style>
</style></p>
    <p>
      <style>a {
    text-decoration: none;
    color: #464feb;
}tr th, tr td {
    border: 1px solid #e6e6e6;
}tr th {
    background-color: #f5f5f5;
}</style>
      <div style="font-family:'Segoe UI';font-size:14px;font-style:normal;font-weight:400;line-height:20px"><br>
      </div>
      <div style="font-family:'Segoe UI';font-size:14px;font-style:normal;font-weight:400;line-height:20px">Thanks
        for the cleanup.</div>
      <div style="font-family:'Segoe UI';font-size:14px;font-style:normal;font-weight:400;line-height:20px"><br>
      </div>
      <div style="font-family:'Segoe UI';font-size:14px;font-style:normal;font-weight:400;line-height:20px">
        <style>a {
    text-decoration: none;
    color: #464feb;
}tr th, tr td {
    border: 1px solid #e6e6e6;
}tr th {
    background-color: #f5f5f5;
}</style>
        <div style="font-family:'Segoe UI';font-size:14px;font-style:normal;font-weight:400;line-height:20px">The
          updates in this patch look correct to me. I'll also do a
          broader audit of the remaining Intel email addresses in
          MAINTAINERS and submit follow-up fixes where needed.</div>
        <br>
      </div>
    </p>
    <blockquote type="cite" cite="mid:20260914210444.638315-1-trini@konsulko.com">
      <pre wrap="" class="moz-quote-pre">
---
 board/altera/stratix10-socdk/MAINTAINERS | 2 +-
 board/intel/agilex5-socdk/MAINTAINERS    | 4 ++--
 board/intel/n5x-socdk/MAINTAINERS        | 2 +-
 doc/git-mailrc                           | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/board/altera/stratix10-socdk/MAINTAINERS b/board/altera/stratix10-socdk/MAINTAINERS
index 6efd0cfc0560..d1a040977c15 100644
--- a/board/altera/stratix10-socdk/MAINTAINERS
+++ b/board/altera/stratix10-socdk/MAINTAINERS
@@ -1,6 +1,6 @@
 SOCFPGA BOARD
 M:	Chin-Liang See <a class="moz-txt-link-rfc2396E" href="mailto:chin.liang.see@intel.com">&lt;chin.liang.see@intel.com&gt;</a>
-M:	Dinh Nguyen <a class="moz-txt-link-rfc2396E" href="mailto:dinh.nguyen@intel.com">&lt;dinh.nguyen@intel.com&gt;</a>
+M:	Dinh Nguyen <a class="moz-txt-link-rfc2396E" href="mailto:dinguyen@kernel.org">&lt;dinguyen@kernel.org&gt;</a>
 S:	Maintained
 F:	board/altera/stratix10-socdk/
 F:	include/configs/socfpga_stratix10_socdk.h
diff --git a/board/intel/agilex5-socdk/MAINTAINERS b/board/intel/agilex5-socdk/MAINTAINERS
index 30d8815d2020..4a52891e015d 100644
--- a/board/intel/agilex5-socdk/MAINTAINERS
+++ b/board/intel/agilex5-socdk/MAINTAINERS
@@ -1,8 +1,8 @@
 SOCFPGA BOARD
-M:	Tien Fong Chee <a class="moz-txt-link-rfc2396E" href="mailto:tien.fong.chee@intel.com">&lt;tien.fong.chee@intel.com&gt;</a>
+M:	Tien Fong Chee <a class="moz-txt-link-rfc2396E" href="mailto:tien.fong.chee@altera.com">&lt;tien.fong.chee@altera.com&gt;</a>
 M:	Teik Heng Chong <a class="moz-txt-link-rfc2396E" href="mailto:teik.heng.chong@intel.com">&lt;teik.heng.chong@intel.com&gt;</a>
 M:	Jit Loon Lim <a class="moz-txt-link-rfc2396E" href="mailto:jit.loon.lim@intel.com">&lt;jit.loon.lim@intel.com&gt;</a>
-M:	Dinesh Maniyam <a class="moz-txt-link-rfc2396E" href="mailto:dinesh.maniyam@intel.com">&lt;dinesh.maniyam@intel.com&gt;</a>
+M:	Dinesh Maniyam <a class="moz-txt-link-rfc2396E" href="mailto:dinesh.maniyam@altera.com">&lt;dinesh.maniyam@altera.com&gt;</a>
 S:	Maintained
 F:	board/intel/agilex5-socdk/
 F:	include/configs/socfpga_agilex5_socdk.h
diff --git a/board/intel/n5x-socdk/MAINTAINERS b/board/intel/n5x-socdk/MAINTAINERS
index ca063a9f3f1d..15ba9de17e05 100644
--- a/board/intel/n5x-socdk/MAINTAINERS
+++ b/board/intel/n5x-socdk/MAINTAINERS
@@ -1,5 +1,5 @@
 SOCFPGA BOARD
-M:	Chee Tien Fong <a class="moz-txt-link-rfc2396E" href="mailto:tien.fong.chee@intel.com">&lt;tien.fong.chee@intel.com&gt;</a>
+M:	Tien Fong Chee <a class="moz-txt-link-rfc2396E" href="mailto:tien.fong.chee@altera.com">&lt;tien.fong.chee@altera.com&gt;</a>
 M:	Lim Siew Chin <a class="moz-txt-link-rfc2396E" href="mailto:elly.siew.chin.lim@intel.com">&lt;elly.siew.chin.lim@intel.com&gt;</a>
 S:	Maintained
 F:	board/intel/n5x-socdk/
diff --git a/doc/git-mailrc b/doc/git-mailrc
index 5a78376aa776..9ca01f59cf30 100644
--- a/doc/git-mailrc
+++ b/doc/git-mailrc
@@ -47,7 +47,7 @@ alias simongoldschmidt Simon Goldschmidt <a class="moz-txt-link-rfc2396E" href="mailto:simon.k.r.goldschmidt@gmail.com">&lt;simon.k.r.goldschmidt@gmail.com&gt;</a>
 alias sjg            Simon Glass <a class="moz-txt-link-rfc2396E" href="mailto:sjg@chromium.org">&lt;sjg@chromium.org&gt;</a>
 alias smcnutt        Scott McNutt <a class="moz-txt-link-rfc2396E" href="mailto:smcnutt@psyent.com">&lt;smcnutt@psyent.com&gt;</a>
 alias stroese        Stefan Roese <a class="moz-txt-link-rfc2396E" href="mailto:stefan.roese@mailbox.org">&lt;stefan.roese@mailbox.org&gt;</a>
-alias tienfong       Tien Fong Chee <a class="moz-txt-link-rfc2396E" href="mailto:tien.fong.chee@intel.com">&lt;tien.fong.chee@intel.com&gt;</a>
+alias tienfong       Tien Fong Chee <a class="moz-txt-link-rfc2396E" href="mailto:tien.fong.chee@altera.com">&lt;tien.fong.chee@altera.com&gt;</a>
 alias trini          Tom Rini <a class="moz-txt-link-rfc2396E" href="mailto:trini@konsulko.com">&lt;trini@konsulko.com&gt;</a>
 alias wd             Wolfgang Denk <a class="moz-txt-link-rfc2396E" href="mailto:wd@denx.de">&lt;wd@denx.de&gt;</a>
 alias priyankajain   Priyanka Jain <a class="moz-txt-link-rfc2396E" href="mailto:priyanka.jain@nxp.com">&lt;priyanka.jain@nxp.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p>Reviewed-by: Tien Fong Chee <a class="moz-txt-link-rfc2396E" href="mailto:tien.fong.chee@altera.com">&lt;tien.fong.chee@altera.com&gt;</a><br>
      <br>
      Best regards,<br>
      Tien Fong</p>
  </body>
</html>

--------------76KaDSnEmWCkHOoLssBtGF95--
