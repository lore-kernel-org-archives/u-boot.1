Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F869606A32C
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mSNslZOY;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=sLebmJn/;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=sLebmJn/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B80C81401;
	Fri,  6 Nov 2026 18:09:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gCSv8DmEqsaw; Fri,  6 Nov 2026 18:09:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D54738116C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793988552;
	b=hLfVgxWQZwVG6t2co1lVSdgDg9PthlSh92cBmZw6RhLMd+HqHQpg51rU0Ody+zMwevH8
	 XmcmMT6q9prEr+AhjXFFDp7b0QAYptIfoZUlgKJvVMjXaGNehWxgXp1EP/ryb/ktkJSaz
	 n4yIp00KhzF2uumNAvlA7iT9NO1MJU7IcYWM0wTInDr6acNVWYiKFYCOlR2Aj1ZuSoZTF
	 mJQTUQXOoUOoTNuhN9DHJd2welZAYjLE3pMwKFgjDsZ7RBPOPuDWcacR57vO5XH5Vz843
	 P7QOtFu/wge8qiWoZ4SGsjbu0sOUpX2iKBWS3VM5abuCegQaX27CWABQrGbKhMflUTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793988552;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=epOSA1ZsfvLjp3mktOJMAAtA8v01lzepTbsVyzBkQos=;
	b=iEvhMUKrMfRE14hGh427ixr1SrWRAfB2i2fI4L0faB45fRKn7p769YIW/ycMRWziru0M
	 1CVgePEc3ZhsaGCJ5uPnI8ybEewuO6BlSO9VE8+L5PI1uIKFTy+dBEeZY9AHBlCLW+5vI
	 MnAqsDAx/DYEEBHO7aKS45c81+OFRkr7y4GK9Y5rhQmwb3KWXOYKTmx3G1fUJg8Nh1eEj
	 s9VkCRhMBvSzUzxcxN9faN2tIxH5l9vadZc0NcMJT3sguflbFWg6lQ3cEt+R0MhR+ogJY
	 Bz++td2w2zZqBgnQySubqS7nf6oeHCwCp6soiLbBERllFB/MHbIHuszmAvD1UWFvsJg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793988552;
	bh=epOSA1ZsfvLjp3mktOJMAAtA8v01lzepTbsVyzBkQos=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mSNslZOYXctPiWkxokXz0DtLLzZqMjy31U2MWdo5dwCgKhLrkSmnzbXECbCHX1ujP
	 lgsFucjzNwmCfp7k2BHlPHgKKxmPhrv/6JxQsW9eEKhejoMjvKqmX/XzQtchQ1U5Mh
	 oGrWSjk2sZPX0NWk3M2VL7FhIxgQXCP/o6F5KnEq45MLRr5jSg4IFYvgjpuFg6Pung
	 3zcyVUjxffFd+L003OKHISrBpalW0UVFHJn1Qn4Q+OuScA+m2P0g2rRjikZilA4HRO
	 mzxPGXqt+6Dv13xUuSQkHBAI2e8XAEUTL6gIIpITja58jsKl96rPn08Gt5wN7srCyJ
	 acg5ROQ/YmNdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D54738116C;
	Fri,  6 Nov 2026 18:09:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D7EA2E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:09:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 53AC440934
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:09:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dJiqJzYVAyHk for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:09:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 41CB54091C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=sLebmJn/; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=sLebmJn/
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 41CB54091C
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epOSA1ZsfvLjp3mktOJMAAtA8v01lzepTbsVyzBkQos=;
 b=sLebmJn/gN8zD0twMZK2OS/Tyn65ytWsg5dt1YXeO6dX+ECmd3NatwVLIDVbNEuTFG6E0PkxXw6BwhLKdtFYL3pKO27HnOKnLl4wlHsr22roig8AkL7jdBpWMb9iTXsbEc7f3TvUxYx5xaGZqI6z3n11V6WP/0f092U9UFXg2WU=
Received: from PR1P264CA0077.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cc::13)
 by MMZPR08MB894748.eurprd08.prod.outlook.com (2603:10a6:190:4d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 18:09:03 +0000
Received: from MAD0EPF000008B3.eurprd04.prod.outlook.com
 (2603:10a6:102:2cc:cafe::4) by PR1P264CA0077.outlook.office365.com
 (2603:10a6:102:2cc::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 18:09:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008B3.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 6 Nov 2026 18:09:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epOSA1ZsfvLjp3mktOJMAAtA8v01lzepTbsVyzBkQos=;
 b=sLebmJn/gN8zD0twMZK2OS/Tyn65ytWsg5dt1YXeO6dX+ECmd3NatwVLIDVbNEuTFG6E0PkxXw6BwhLKdtFYL3pKO27HnOKnLl4wlHsr22roig8AkL7jdBpWMb9iTXsbEc7f3TvUxYx5xaGZqI6z3n11V6WP/0f092U9UFXg2WU=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GV2PR08MB8193.eurprd08.prod.outlook.com
 (2603:10a6:150:78::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 18:07:25 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 18:07:25 +0000
Message-ID: <b82527ba-193f-405c-ad94-eb72cc0a7762@arm.com>
Date: Fri, 6 Nov 2026 19:07:25 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v2] x86: Handle unordered runtime relocations
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 James Hilliard <james.hilliard1@gmail.com>, nd <nd@arm.com>
References: <1a8f4816-bae8-4fce-9189-4668f781ca58@arm.com>
Content-Language: en-US
In-Reply-To: <1a8f4816-bae8-4fce-9189-4668f781ca58@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0057.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::14) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GV2PR08MB8193:EE_|MAD0EPF000008B3:EE_|MMZPR08MB894748:EE_
X-MS-Office365-Filtering-Correlation-Id: 32968f86-dbf2-44f3-40ba-08df3c3109f9
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|261022075727099003|260925022911599003|260925021911599003|260925021311599003|56012099006|11063799006|261021121427099003|261026140227099003|261009223027099003|261021123027099003|261028144727099003|261022115727099003|261102123227099003|261022105027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original: fRW54XPet9WJW5WQej/+j8Z9+Z2WIJezOGIexkk/+aSquJrBXPpe//e9hbTcOqUSSP+hS6SaINhi8ECTDZy2bFRmaqU8+qjYk3QxF9FbaoSRjXP60L6/mIVzznTbzss0/73MeB2CnEeYu/N1iFPu7U6HRMRqXL3ggPxRcQ1A996hdzL0LzOzLajO5FvmoNfaBP4jqcaA4Oo8J//a+PHPXuuI8qJkepL9wGMJe3ra6AGiVbgvj6MMrMuE12aquZs9su5E8qln8Pj5OjKaXpSbaxRdeHapEnyxjlHf5IUZHbvdFCO/pYnDdHKDFod11+l7Z/QifSU2cr7GRD+xTTr6kkY1uY1M7L/+s3EJga3XN6gd+47+Y/yJBfhNdlDsqiJc2YBBdGiqXBTtV7z6QKMsG1H4JoZFJ2tlJkef1HV7Y+ZuPm/5uVxCY1B9q5B8yQMyOdl2zAZkBW/tnvoAqnFwCQWIHBNkz/7PA/lGRR97facQ+pF3daXy2pR+W6pCrtT/7F59puzQpbWOKzhO822tyVp95YQ5LREKpA+EZSfmEqXxFw+AO3HNiRssEf0z5JMQ91sAkYDeDaGYvhqDxnj81L4jRydBfELQgruQKClQKqQkVHlSan+jCV+AUSfiUoZo
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261022075727099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(11063799006)(261021121427099003)(261026140227099003)(261009223027099003)(261021123027099003)(261028144727099003)(261022115727099003)(261102123227099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: My0P22swikB5TqJMo2z0/rfe/T0i5xrotLAFuyoNY3GArjUJy3FNgRNTyUEGjOayakmjaz3br3OCMFEe8nIu3fqd0sW1nSbcky2axwsmRDUPIAqsgHAFgWowwGPG92lZ2qn77LTNpCLimrsgisnw09xixewgElXc8Amw9MJPr7j3sdE+gzfZIGDDkIMgczD2vdSYLe4le2aZ+3xMVKr3ViRsb+MgeXYb4FUyU+wKFzN33h6GRUDCLv56mue+OCFeKOXJZTvKlHnYglDXnx0rn1oY712b/9GSyrFbrc2wmp5JeocOk4OtvFLZ8WSafxsmks8d523r/+cfkz82s61cWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8193
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008B3.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: befcea53-a237-433a-983c-08df3c30d001
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|35042699022|1800799024|82310400026|36860700016|14060799003|260925021911599003|260925021311599003|260925022911599003|261028144727099003|11063799006|56012099006|261021123027099003|261022075727099003|261022115727099003|261022105027099003|261021121427099003|261009223027099003|261102123227099003|261026140227099003|10067099003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: ryPitvmWHLVbLfFoI844KaANMJ9pKDOH69AjvaSSqGfT+gksvSkrvm8vx5olZnW4TZSbwyvBXANjhmZ90NOnj7//E10x7zMSAkbaGRK4ihuc9aEL6/81QFmyqeQgxWKbsM5ycEWDG8B0EKUghetzwNQoxMpUdG0604e0eCeDf28eu2jtGUqbG0ZSrQudRowRsF4nPb4MC4qgp6ME8sLnQwFtg1vr541qIyi6yf6m+1xOHPKzJnSGpwk6C90VbXdYSuvJ2fBbnfDU17Aj3YUoRzn0tXB3kShK3LcsT3bpXJoJ2gQnkYkoM80GTsHaEDFWeNifBEjd8fdZKyLOXde03PKkd8E7Fp5ZBGG0FCa3o003Yz3p8D/uoUjCQox1cibEU7/cqEx2fJ2cFUJ5Xv/0kwSWCs50dJKNdhDMxd0KBNHDIoFQhbZxv090v/wb9r63OuT8NuXKyobYqgCHeZXKS+Ufe9Jiqr9jGk+bsUWwzUH156po+szw778zXeCqAX3mmYlqh6FvLsKPxhIc3XgUweyXlY9qPdeFLyZaWtu+pz1WoUilor2/dQ1la4zx2rWHCRD7/WvzpSjk2I7daBzZC28m+c5s436zWZexQ0U4K+zeTgyuIOSflLcMMiyCHhhsXqwsXZ83cg9vjzNZwNyMIzIagjYb/jw3pCKYUIEkdrM=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(35042699022)(1800799024)(82310400026)(36860700016)(14060799003)(260925021911599003)(260925021311599003)(260925022911599003)(261028144727099003)(11063799006)(56012099006)(261021123027099003)(261022075727099003)(261022115727099003)(261022105027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RrBOHj82CLRb2iwdkFgHpA5If5SWQuyTKd1A7Mdp6yetHEpnhKMhenC5nzcP94lKq7uGb1iIuhbWpWKZYksB3eofAFe0uJP52qTwJ3TdrSP0F23dT7aYuD1mUkXbiZQK8U951HRHPspedqnjN5t7YFkZ2x/uQSpCxTjYSYZfCUOp5fRr+jI+265RE6tP3W+iFZbkSKa2Mld5Lr5hzpen8ZZzVPMfdavmC3InAoAUPEV9HfaPm0V6kdrGzYnArOQE+xbdD51ojAI1dZyshY0DLHFYNTFNMcYWWAAkGwoiu3SlbBCHoaAAQsmSxGJhFSGPaGP8b2pvig3TXrBC8Srl2KXX5NC9irum1CtJJCYOpvnWFAf0DnX3BvIPWVopstaLhtv7oM7SJK6QLMZi/TTOSQQTauZ3IKACE7bFhm08JrVmAxzv7mxSY/RcOi3iQD7K
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 18:09:02.6709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32968f86-dbf2-44f3-40ba-08df3c3109f9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008B3.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR08MB894748
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Runtime relocation entries are not guaranteed to be sorted by target
> address. This was observed with GNU ld 2.42 when linking qemu-x86 using
> --emit-relocs and -pie: after an unrelated image-layout change, .rel.dyn
> contained 450 address decreases. The old code skipped relocation of
> mem_malloc_brk in sbrk(), causing allocation to fail and log_init() to
> abort boot.
>
> The ordering check was added as a cheap corruption guard because .bss
> overlays __rel_dyn_start and may overwrite relocation entries before
> relocation. Replace it with lower and upper image-bound checks. Together
> with the existing type and target checks, these reject most corrupted
> entries without requiring sorted input. A corrupted entry whose location
> and target both happen to be in range may still be applied; the ordering
> check likewise could not reject corruption that preserved increasing
> addresses.
>
> Apply the same correction to the 32-bit and 64-bit paths.
>
> Fixes: b50b1633c022 ("x86: Add support for 64-bit relocation")
> Fixes: 62f7970a5a06 ("x86: Add error checking to x86 relocation code")
> Signed-off-by: Jerome Forissier <jerome.forissier@arm.com>
> ---
>  arch/x86/lib/relocate.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/1] x86: Handle unordered runtime relocations
      commit: 4c08266b7a6654f731167e615f00e0676750497c

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
