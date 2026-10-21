Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78020606A31C
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 02:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Idi51kpf;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=mSRkXZez
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55E2660763;
	Wed, 21 Oct 2026 02:22:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CZh5PsFEBRyp; Wed, 21 Oct 2026 02:22:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6C67D607E0
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792549324;
	b=TDwxKNfuZWi7g2oV85/+3BYq577xzpuoSBPgDUDpGMINfxsVuKDGkHQ1TYnDaJ0iW1NC
	 kripzSbkt3iz0wE7J0TjhVYqBmKWw/UqKpewmyzwIc2WXfe8uiJV63yNSq0+K4ldMlov7
	 vGvERSQ1nKSDRc8frMgP/Aw9Cw3ZUgmLjFA3cKYkk29qjMNmwQ295m9s0KC07wcafqZfO
	 tuNrW/HTCkTP8n1kGjKoPwvi7bKLxYgraI/FBhki7czfqwfM3/rbYIZavMS/hAPVONgD0
	 d85VUqarOtkt4NoQUA4Bj0e/ZWguTjW7v1vroyXp11HzA12VA0Pd9ks84a4cpFkxJsQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792549324;
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
	bh=4QG44QPZd3ECTtzM4of1rMaPJIEa9+/n/AlAitDWuWg=;
	b=PofLuHKHp+qyVsTLj9sYUeRRMBEY7yWyCs3RCj+Na+JQhbw0DkRT3OsiSdS9ZR8Zsk/V
	 V1PC8mu9Rn4hMBU544zWDJKzaiEI0f4muAUMSPHjvKNxZZH1aWMrR6ZeISMVx2dABL7ui
	 eVFVgIXozWUSA69gigU9M+Xu1kP5acPHkFzudzchBR/a1+Rf30ydzppBYi5pBmLngmCZa
	 c/Xs+duvAfX7UfaD5RdsBlagYU2hAG5SEffT2V0Cc0DLBimo7l7p/esXluYQ6fD2FoPQ1
	 h4OvmKQKIGYBI1WXxemXXq9H8t6QVRNuKRs72jl0RfPxe3mHV7dDbDw2CyT9CXrMrIw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792549324;
	bh=4QG44QPZd3ECTtzM4of1rMaPJIEa9+/n/AlAitDWuWg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Idi51kpfkc02QUepk00gNSET25tlFyc6RTWHXsaH2n+j88yrUZFiQpgxYTHicAHmJ
	 9k/1AcbSlmCqVE40pWqFCe0VW4JUqgWI0xw6NuyVkN+1plbxQbKZ+xT5/hmsZKBLcE
	 GcWH9EF8E+pgiQV2zziSttIbCoK7cf+LMP0TfF9E4Us9igh0sYynZnio6ejBK4dGXq
	 /V4hrKmTde9RJ/dsULYFaSgOEVmQxVwEBDQ3yMb8i07b0ZXjKiSGvSdTqQjAtgOsxv
	 7SgPskQkondxYOwM0xMYFjA/3rj4gijdpaqRdu23Uoe63czNlgYG6oPnPtn54euDmI
	 DoHdZO9THxXRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C67D607E0;
	Wed, 21 Oct 2026 02:22:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F59C995
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 814E081086
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:22:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wuEw9JBNothB for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 02:22:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0844680F90
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792549321;
 b=eZ7NdOG636EqX0/S1PklulD4iVz87Rs1fvZD0lT6/utcWlMX+VGCPUnm1LHvCGsxo7WL
 DJMmuSzkQABkIOWuZT/K385D9+hGTscS6swRSgP5cjJD/rMf/V7oNO6z1zxYI5k+Xfqge
 oEJDHVhHyeNEbCMWzdM62zyLjR03qpuOzM7lLrs+Wv7FS/O+dvAsE57RUQsKOExoqgJy1
 VyPm/Ji3iTCVsEvBaoiRidMZXDqkF+UUGscyk1yz08oaTtrhGJCgQ3U3I0C7dMnLhpmBk
 i9LHglezzpXllRgA0wESdRexRBZB/EN4pApC6x76pfxTR+G5xTZZk5DkSRNNppBM1+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792549321;
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
 bh=4QG44QPZd3ECTtzM4of1rMaPJIEa9+/n/AlAitDWuWg=;
 b=f19QshQHcXskoFRpoDrdvSIgaEnSfsuOi0Be8JhkEHqc0xHqQFNihhmnrWuUwGNLmDny
 HzuPjAxtx3LJKECC3dlS1jcFr7GGLQ8cVgFMzjg+WJO7/otoWtu8Bj59Z7D50X9bmBuWx
 U7siFIzkL+aZKrZn/76K1Aq4d8rpaGGbSdgXEy3qj74UyqtfSxjTi9IwiD3tuxoCq+8+b
 1rpPoYt6Xv9HwcdJCBqcRkVHyW0Q3OnMSgKFW9oOzq3cFjVBZ1oDhf7VxiXOetP81GqQH
 UbsMwKlqs2A05wrLbHaqy5ZX8aWDCu9XlTjTiG/Fquae5M43v2wpC3YiirNJMwkBYWg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=mSRkXZez; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=tien.fong.chee@altera.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=mSRkXZez
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0844680F90
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:22:00 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF115844F6; Wed, 21 Oct 2026 04:21:58 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BBD68056B
 for <u-boot@lists.denx.de>; Wed, 21 Oct 2026 04:21:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYHc4oefkikHeRnE6e+w5g/rr6E3LzytlTq68W5KH3mYXGJd8E0IGyjD49wBGFOatnbYHsZ13gGP7PCC/0ALh+M+c5ZlDfcqKKbP+1Qc3cdb7Ruht6KxbJj9FTfzuPW3ZQbmJAYnwKfhR1Y2iCxk20I1XXdKauYWQhAdveCVzt2W1wnc9nlPzf/iKIztpuGrT/PTOU3dofip5VZ7Hi+//wF4+L6JYvuLwtz6AELSpDMzu/rO06XIFHYkOzR7DlC0WWi87apuosBN29hURay+etEV8ce9JmClQT0DUJPtWrl7w0aXM9iDA5zcBgXz1W+RkdHKAiKK2jz5gsiLG7NzOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QG44QPZd3ECTtzM4of1rMaPJIEa9+/n/AlAitDWuWg=;
 b=yAOxDvUwM44mhGubeF8htoPfBrm5ity+gAbb6kL94oCCtvApTXVfKK469dNDjjsqv3TS/v4OQvOVqiCHm+r2E1hOi8R5yu7we7gJxMitIrVJUhun2Ev2rCgwZRfX1vubPnnRGQ7oL9p9zF0FdzKRSSiEzp2Sm1RfDv3fNIn7jS5oGqJUj4PNMtKF7mewFVsVTojEV8anS1WqaSIpCumM0338bZDKPHhOanmkVCjrVMeEZJK6iffEJvhcv+EatfbrqUx8Qxw8AduvrivkMWbfR102q+UuUAmbZhRVWTMWuFUJyMn7tz7UAPVKKRgFNuGCi87u/EkUqdbUjCoG4o0A7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QG44QPZd3ECTtzM4of1rMaPJIEa9+/n/AlAitDWuWg=;
 b=mSRkXZeznPbWaJb3eNc+XuBJZ6M4p23hhhsQGjZIPcbhBN1TDckcQw+VRW9/I3FoMMuNtQkHoLA7YfEm4AfS1jK+B2Ux2gNBfRXYes5MZt86Rtfrso8/gtbzSQbbsdjZjN+uxLaV36TJoqUj13RRbTqUq0CncyQqOiabCTqWfSEZWkfhQrqkcmdWVvltZo1RTxdAH8miq4XJZYS2Az5vwTm/Nqj/sREqfk+HUsBU7Qv4MjVZLzVzCLpk4JeYQHvs7kaGRUIZfWI2yttEZLn0r3GnLjUlVN5TAMmIMgbyIX5fve4qKBOWuvu7lhCkfQsPLi4rKaqqL0P0fchvMisvqw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14) by CH7PR03MB7833.namprd03.prod.outlook.com
 (2603:10b6:610:249::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 02:21:49 +0000
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d]) by CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 02:21:48 +0000
Message-ID: <fda8c37d-17bd-44b9-bfc2-d8db757e7939@altera.com>
Date: Wed, 21 Oct 2026 10:21:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/15] ddr: altera: n5x: re-init DDR after watchdog
 reset from init hang
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20261016044047.21496-1-chen.huei.lok@altera.com>
 <20261016044047.21496-9-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20261016044047.21496-9-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0190.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::19) To CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR03MB959535:EE_|CH7PR03MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa11929-72b7-400c-d791-08df2f1a0f8c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|55112099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 2txxA5DVIheM83tFxT1QZk/sXIrbIM+LgNGYi33a1WdNxtrZZ6J+gb3L+NK7MtGNvo0G/AtoVQcsF2/tgGZZn4LuuCiF+E0eJFwF4aC42g59pU7Em2MnVL/OUMDhNR/5RlgYfSq35YU7BYF7dq5VJJkoKPK1w85+2N+NYk7GnlKmAcY322B51aKgUcn0j5rQFD7a1Q7Jhz2QOheeDWur9T87S4UgfvlMYAeoJa6M/meUy9KDjLeGuWwIv4Elmo6IVBKtpSofxBhxGrILKX2M4K8qF5G97MYlzkE7pg2ynL7JVfr7g5hL8lLpZvzmTZ7BmHyjIqX5Ss0+TPl6tyJlWUQAYbKjQbOuuC3P2+pD3kqXS7uY51seXug3IjdbZy1YQ+lK2IMJg6ng3X1EHT7S0lIFb7wkFJciRN46OQQItFhzX8SgWtGM2m6XXxj2ebSnkb1fBa/cloGm28Ra2ZEepNVoA4c2KbWs0sbsjEui/t1EbchyEbuCBy+KTV1oXcqwJ+5Je+KKiQL1PldoDxZL8gLbdpzQhFP0fw3xJ06jpMNjR0iM5GK8UEpkPX+afPFSU4oMREswOp7WUzRA81b+Vcc6rQX4m+LtG99liH96VWB1Pmt8Nl3ZbPqlXkSmpjkhfNDpFkq+4sOna9ABxsGc9wYw4sbJaX+QZmP9m0W268c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR03MB959535.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(55112099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlJPOGpFNTJpK1BKL3dJNm1XRy9rVFhqaEkyYnJ3b2tNYXM2SlZSQmRGNC9L?=
 =?utf-8?B?bEJNa05DS0tUK0cySkdhb3cwZ05LTGlkUTVYV0xxYWNLSlh5dGpydUdQL2FQ?=
 =?utf-8?B?KzQxNVRxcVh0cSt0OVU3a1hrVitBMEdzcTJaWkNONThEdE5xZEpHS0w0UUla?=
 =?utf-8?B?NWRrclVjcUJnR2lIYnkxZWtpTmFCQUpQeVpTclcyUGZEY1JPK25SZzFZL0dM?=
 =?utf-8?B?elZxZ2hYdXpndmxWd2hCSGNVYXpza251UG1mOGIxUGVYdjhNOE13TVFYLzVC?=
 =?utf-8?B?cGpYUXBmQ3JDMUdueHhZTDRrZHFDNWMyazkrK3R5SHRYTmFNTjdyUjB1NTgx?=
 =?utf-8?B?RVJtVTIxcUpGcEdEQld6VVRZUnZhWVppc0RCTHFwM3NxUFhoNW1naVErNklH?=
 =?utf-8?B?cnltU09zejRMQy8yZkdNNW9hY3JiVVN0b1lwWWZ2cWpld1M0Szk5cXVVdlcv?=
 =?utf-8?B?cmwwZ1FHL282TGxsakErOHp4RkRHNGYrSU50dU1MYVEvaGVvQnJyeUhITnZS?=
 =?utf-8?B?WFZUaloxTzN2dnVjejhDN08vcTYzdnVDM1lYYjBFM0lEVlQyeDlVS0o5RXl5?=
 =?utf-8?B?OExVZkJqQWNtYmFDYVJnYU1wb2xtemI4ZGJhUHh4QTlmL3NTd1Y3cnlZZzZs?=
 =?utf-8?B?UTdqQmc2YmxLTGZDOXhwNFBCMFZrbW1mVHlNYit2cWptemk3SDgzT24valRP?=
 =?utf-8?B?bVZRT1BXMVZkalNOYWN3c3UwMTRYTWxyUWdGL2FuSVMvZHEvMy9hbjdyOUNK?=
 =?utf-8?B?M1ZkaTVLVVVlZ1BVcnNqUnJqeXVRUzY2QVFqZVR1R3RXVkxBcE1mTmZKcDBl?=
 =?utf-8?B?TUJmc0ZNa3FWUTFrRXpzTmwwMGR5SkJTd3k3MGJmQyticzIwNTZET2hybVZC?=
 =?utf-8?B?Zk1pMFFaRHNOaEVJWnpMS3dpZjFVb3lBRGQxbGlEK0xaZUFBOU9rdmxJK211?=
 =?utf-8?B?SVdtOTROUUc5TWxlWlA2aTdUNkhGdlRSOGtiV1U5bUs2c0gvYytnVEY3YXZh?=
 =?utf-8?B?ZUFmSGM1Y0VrN2JmRkErTnJCMjIxTHNmV2hrM3BTUS9MWWQzNjVxcDhEKzJM?=
 =?utf-8?B?QXhub3drT3kzVFZiUkMvQitoUUY4bUE1bXJRdnI2QXlDcWdPWHBITHZyVjNI?=
 =?utf-8?B?K2hZSmIya2FvRThjNk5MdDZqWGN1QXBncmJxZ2lVV3JzbmRkMU1QcW4vSTgx?=
 =?utf-8?B?QS84VEdOTlNUTHpUVHA0UGZWOXVrVGVLdXZXWUlSVXREMEZuQ0tzUkJKMHdI?=
 =?utf-8?B?cEtrNjFBRExuMHU0dG9aSWRlclhwdGs5TE4yMzBrRERybWh2NlNhUmlHbmd1?=
 =?utf-8?B?aXAwMnJBQTFzczRETzlhOTZuVTV5aVByYUJoTTJZYXVzemdOUUxJdVRuVjJB?=
 =?utf-8?B?OXIwelF1ZnNZLzRUcU5PMlc1bXFWaVQ1Nnh5WFU3VjRrK0tvdlE3Y0dQdG9M?=
 =?utf-8?B?aExRWDFPV3ByNXFLL1duVU1WbVZzNitCQWlvelREVEpkVWlhUnZyWWwrVkZj?=
 =?utf-8?B?dXFOcm1pMXF5WVpXcTNJWGJoNTdidVR4Rm5vLzh4Y2dwMDRxcWcweDI4blll?=
 =?utf-8?B?SnM0Rit4VkVsRVVNWGEyNnJtVGpqVyt6bXhUTzUwQ2UrWFhkOUFUSTZUOG5x?=
 =?utf-8?B?dUN2b1o4RUt4TmVKWitUODVGcjNVYXByTHJxSWdXZ3hvL3BZZWFES0dMbnRq?=
 =?utf-8?B?cVNuUW5jZE1nL0x6RnMxVExMcnBNODB3eGUxZEN2U2RhcTROZUErL3prNlBH?=
 =?utf-8?B?TXVlckJ4NzVzbDJEUjVLZkFoUmw4cXpPdGVuVjd4N3FqdFpQYmtlSnRFWEVr?=
 =?utf-8?B?WmhTTEovM3Mwd2JxaDNxNGlhM3B5SDdHQ2pENnQxNDIwWDUwb0NxWThEQ3Vr?=
 =?utf-8?B?VmhmRE50Q2dNV216Yi82b0FmL0p6eUEwdG10TW53VjRBT1RIb05FUXdvQ0My?=
 =?utf-8?B?TGk5emh6MFh0ZFZtaTlsZ29uUmdFdTllZ2o1VUpGNDFVeWxLSEJHTTI2ZGdN?=
 =?utf-8?B?eVlGM0lVTmhQNzZwOG92bEg2YVRpdGF3MXAxOUIzbmFuODh4STM3NS83Njd5?=
 =?utf-8?B?amRNUzhwWGk5U2ZHRHlzV0t2VTBad3NRN0pGVTcvdTYyLzlDbDg4MkJBRW5H?=
 =?utf-8?B?VWlvSzlPYUtsVE81VzYvNG1UT0VQdzY5Tm1kdHNGREE2OFIrOHhLeXI2Rm5x?=
 =?utf-8?B?bi9iL09hZTZMUnNyenhoRzNGVzl3VnBRWktRNzNvMytKZXZ0Njl5cFkzZ0N0?=
 =?utf-8?B?S2xIQ28wUWtlOVc3VWQ5VVpDcExmRk1idzdvRURJR1N6SUdoYlA0QTFxdnNQ?=
 =?utf-8?B?Q2lJd2RJWXpOVkwwZHJpdXltbW5yaHRYaFdvR3JPQUp6cDRFZzMzdz09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa11929-72b7-400c-d791-08df2f1a0f8c
X-MS-Exchange-CrossTenant-AuthSource: CHBPR03MB959535.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:21:48.8968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3i6jPuYeA7izpTBhxmAe3LlqJkj/Hp3RdvdXUx05EJ1ZDrlQVa6GuTb5NW/OMF4aSYGpBntlUPYInogDZ4CC/oACWforyepF6KzbAhr9H3I=
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
> From: Tien Fong Chee <tien.fong.chee@altera.com>
>
> If the previous DDR init hung and was recovered by a watchdog reset, the
> DDR state is undefined and must not be reused. Detect the init-hang
> indication and force a full DDR init and calibration instead of taking the
> retention skip path.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>   drivers/ddr/altera/sdram_n5x.c | 29 +++++++++++++++++++++--------
>   1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
> index 1bbd5bb0082..858f2e76aa9 100644
> --- a/drivers/ddr/altera/sdram_n5x.c
> +++ b/drivers/ddr/altera/sdram_n5x.c
> @@ -420,6 +420,17 @@ enum data_process {
>   	LOADING
>   };
>   
> +bool is_ddr_init_hang(void)
> +{
> +	u32 reg = readl(socfpga_get_sysmgr_addr() +
> +			SYSMGR_SOC64_BOOT_SCRATCH_COLD8);
> +
> +	if (reg & ALT_SYSMGR_SCRATCH_REG_8_DDR_PROGRESS_MASK)
> +		return true;
> +
> +	return false;
> +}
> +
>   bool is_ddr_dbe_triggered(void)
>   {
>   	u32 reg = readl(socfpga_get_sysmgr_addr() +
> @@ -483,13 +494,13 @@ void reset_type_print(enum reset_type reset_t)
>   	}
>   }
>   
> -bool is_ddr_init_skipped(u32 reg)
> +bool is_ddr_init_skipped(u32 reg, bool is_ddr_hang_be4_rst)
>   {
>   	enum reset_type reset_t = get_reset_type(reg);
>   
>   	reset_type_print(reset_t);
>   
> -	if (!is_ddr_dbe_triggered()) {
> +	if (!is_ddr_dbe_triggered() && !is_ddr_hang_be4_rst) {
>   		if (reset_t == WARM_RESET) {
>   			debug("%s: DDR init is skipped\n", __func__);
>   			return true;
> @@ -509,13 +520,13 @@ bool is_ddr_init_skipped(u32 reg)
>   	return false;
>   }
>   
> -bool is_ddr_calibration_skipped(u32 reg)
> +bool is_ddr_calibration_skipped(u32 reg, bool is_ddr_hang_be4_rst)
>   {
>   	enum reset_type reset_t = get_reset_type(reg);
>   
>   	if ((reset_t == NCONFIG || reset_t == JTAG_CONFIG ||
>   	     reset_t == RSU_RECONFIG) && is_ddr_retention_enabled(reg) &&
> -	     !is_ddr_dbe_triggered()) {
> +	     !is_ddr_dbe_triggered() && !is_ddr_hang_be4_rst) {
>   		debug("%s: DDR retention bit is set\n", __func__);
>   		return true;
>   	}
> @@ -1598,7 +1609,7 @@ static bool is_cal_bak_data_valid(void)
>   }
>   
>   static int init_phy(struct ddr_handoff *ddr_handoff_info,
> -		    bool *need_calibrate)
> +		    bool *need_calibrate, bool is_ddr_hang_be4_rst)
>   {
>   	u32 reg = readl(socfpga_get_sysmgr_addr() +
>   			SYSMGR_SOC64_BOOT_SCRATCH_COLD0);
> @@ -1627,7 +1638,7 @@ static int init_phy(struct ddr_handoff *ddr_handoff_info,
>   			ddr_handoff_info->phy_handoff_length,
>   			ddr_handoff_info->phy_base);
>   
> -	if (is_ddr_calibration_skipped(reg)) {
> +	if (is_ddr_calibration_skipped(reg, is_ddr_hang_be4_rst)) {
>   		if (is_cal_bak_data_valid())
>   			*need_calibrate = false;
>   		else
> @@ -2820,6 +2831,7 @@ int sdram_mmr_init_full(struct udevice *dev)
>   	u32 reg = readl(socfpga_get_sysmgr_addr() +
>   			SYSMGR_SOC64_BOOT_SCRATCH_COLD0);
>   	int ret;
> +	bool is_ddr_hang_be4_rst = is_ddr_init_hang();
>   	bool need_calibrate = true;
>   	ulong ddr_offset;
>   	char *endptr;
> @@ -2845,7 +2857,7 @@ int sdram_mmr_init_full(struct udevice *dev)
>   	 */
>   	writel(SOC64_CRAM_PHY_BACKUP_SKIP_MAGIC, SOC64_OCRAM_PHY_BACKUP_BASE);
>   
> -	if (!is_ddr_init_skipped(reg)) {
> +	if (!is_ddr_init_skipped(reg, is_ddr_hang_be4_rst)) {
>   		printf("SDRAM init in progress ...\n");
>   		ddr_init_inprogress(true);
>   
> @@ -2887,7 +2899,8 @@ int sdram_mmr_init_full(struct udevice *dev)
>   		printf("DDR controller configuration is completed\n");
>   
>   		/* Initialize DDR PHY */
> -		ret = init_phy(&ddr_handoff_info, &need_calibrate);
> +		ret = init_phy(&ddr_handoff_info, &need_calibrate,
> +			       is_ddr_hang_be4_rst);
>   		if (ret) {
>   			debug("%s: Failed to inilialize DDR PHY\n", __func__);
>   			return ret;


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

