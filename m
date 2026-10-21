Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F6C606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 02:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qg4Vo4pm;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=vw+t2pSb
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DBB26078A;
	Wed, 21 Oct 2026 02:10:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GNow2LadpbXW; Wed, 21 Oct 2026 02:10:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5837E6074D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792548601;
	b=Nj273raoPC1fSruR7Is8BSsg8/InpvspT4ySyf/BRPvoEWykAjGEttY3uXEPHMtBIuN9
	 qhT8h0SPmp2ZmkvCIOYUzEyp70iHxOT/qKpSmgTF1FbO2W4gdlaPHGPKBx9SHSRTE3w+m
	 svNWQbyFuMHaAxLdPLHj27Xif+LEgBvHq83hGP7PVrJvpp9dWVU+TMYkQJQ/fdgm2ZKwg
	 nJAg6Gak25SGCxP1EPCrnG90RpbOMyCvT3Ie6q99hQHUj4MfmippWTkQrQ2cqxQw0a3+2
	 /eyTM+wwqek1+X+SAK+ChBQKwvkC8/OB/FixPGlW8d5zRsgnPhF2cVuFMf/0qaO0d4g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792548601;
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
	bh=m3RABnOZsT++/bKgQDBATnFEyM6OA7+fYRPpQINP+9A=;
	b=gb0tVhY2JaP6eQoZ98uBL0gN+CV93S0l7D6a2Gc11IItHKumLmsPG7PUMsn4BLdCfscu
	 EMtkPzOetbgJvQOIasI66gUo8wDdhT/Ixchwd5ZRykoSluPRkOVJOfa9geums6z3Stt3K
	 Xbc1ByI3yb/rwqYZmulNVlkYLX6oszAXhBXbk8kcKvZ9KhYLXtumCXf9zyldyocPET7XP
	 1dH20LS/hTqWhsuorFWJLCZwANEWihlMFQwMaYDtXGXaDJ5ceo3fUBvNor8wBwf/y35Ib
	 ECv0X7oyMbYQfryQhHvzGtKMYzawdG5x4gn4jx5zSmuzDI7wVs+j9qguHszgZze2vVA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792548601;
	bh=m3RABnOZsT++/bKgQDBATnFEyM6OA7+fYRPpQINP+9A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qg4Vo4pmGJoxBceUdNbjInTdmzdEZMM6H3JryCzozHEJuQ9ECJaQHzaum15jU9Mpm
	 6XisFaTg4w+2JJqcz3efcVNiE4vq1ZNKETXf+FCJRwz3SfAKVDafx3cO05wACImZ1A
	 PufK/sAxqdHzLPT8tGJAtVGfWGjSeBrhuQBrx+XyLiXx/B4aGkjAvCftRhavbt9vtO
	 ZxnHjKYOWI12H97Xz071ue3qWUjkDylri1CpFQ3ji98gbWjeR7aeRN9nAwSmCim0wT
	 6Domiu+qotjz9uuzjmtQ8amMVSuk1PEmnsQHBJHH89N68lfGaCrEIG6DXYYthayLgQ
	 nztkFJbfQs2Tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5837E6074D;
	Wed, 21 Oct 2026 02:10:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3675B995
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:09:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2839940775
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:09:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p5F9xthsV9Ca for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 02:09:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 66EB640758
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792548598;
 b=E6BTJDy4UK/qDFaO1Y8ZsHIziQsJICqkwcBXlgOQDyoQ2XEvylKjePLQPfSNzvWVZP0J
 xQNTVtTaivCl38Uo6+CgRVfjbHqdR0cpbRq2/8+qgqxruITHaMhchWHajGF10Ckgr2KS7
 MyR07MM2jGNP6zyLFdoKkK/Yfz8W5H2kQyGLkqNCJEm+ag+mc4uwVI+HiuvAreVjv1sTv
 giC5tI4JBxVuOKU8ticL1Wpkwturu2UkLKiFjRgdTYg4VMU34OwqWVFvS9EPrtKS5Zjz/
 +Dzi4PzOEt3ei0YLAbJrOTt93/bZQi7YOOJQ+GAA6u6VOn8MychsZn/UwtNmp6Wv2vQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792548598;
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
 bh=m3RABnOZsT++/bKgQDBATnFEyM6OA7+fYRPpQINP+9A=;
 b=SG+d1zHZl1sSCA8OxJua3+9P/B7veTqveOtr2iEC2mX4uZ7/QiwqF0apT2SGSqVowcM/
 FKoiAMeSYNTYn+2ivHi9QFHT52JnXLqzOvRrmqtZv/kxVk2Uw6qTMnAT2A5dnbx/I7eFf
 /5M5eY2w4cUedO2joVJGsZ+wxEMWbRk60GkW+sBMWyOUwK3bQkINk6hAR8o9cnReMDWzZ
 PlXSZ0mFoDD4XEPDBwcQNHLcNHCjnBrsn5YUROY4D2VAhQehtZi6gfgnuTisn0ThV7m6k
 0T3PIysuX1bnBllQWau9I75JROEcoYxi3qdY96G9abjhoh4ONhll2/ezcXN7/iH1C0w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=vw+t2pSb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=tien.fong.chee@altera.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=vw+t2pSb
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 66EB640758
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:09:55 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EA8A844F6; Wed, 21 Oct 2026 04:09:54 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01F7E8056B
 for <u-boot@lists.denx.de>; Wed, 21 Oct 2026 04:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mi6CwWnYKtvSF7tEdj5QOsuLS0RbrNGRcU/2ECQom7g9HN/ytCE9qcJEZ50GTViPUXMOJofrZkTQUwO12mn644OIVdhkeIi4+iLgfo2nOaobju+POMqIUQt+kCU6+Y7fRftYYKd4Wd5BjKbnqpajbniH1GD1vS1j6MJaJGvky71x4wlPg/NsNtDLBPMvvRvLEdvFMLkn7CE2s2IkGpDsjqPHVVKjSW67Q5O18PtFSHACMHWhXiLxnt8pIjZt6mFtz5w9qTSPVr9t8YDzOKKSJ9TAIlj+xG3UfiEk35txVNksM/41aXWUX2Y1VejNiYUyERcg4unyz+wv8LumXskiuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3RABnOZsT++/bKgQDBATnFEyM6OA7+fYRPpQINP+9A=;
 b=N9KGDaqh5GjqfiqCq7oO1dG0IG0NFS0ID18Dyt/kBUtK8tEAFmrW5IGw5PnblZhgi0jrKb0pzIExbm0r7bn/7e4g3VjuQCWq5ZkL6uzB/UbTzhzIpOk/cOeQQZQvt1wwcTZnTDvquBNBIfn/LHoR3apOGp0TxKqEuOcgRQwT36jbLcNqgfulryvW4SwPts0CYR70cBpGyediensucev7T0HuEviqv6RfuZl94RU7hLFIr7HvrmraNNxXAMGtxI3081n9Zlovxouioh/zz2F0iV7/OW+FUIXYXgthWdgRVzAcgP+ScCjUpqSHv0J0jL9qTcDKHYc/QflHFQwhnZCfVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3RABnOZsT++/bKgQDBATnFEyM6OA7+fYRPpQINP+9A=;
 b=vw+t2pSbBrkw0sznTuezjNMQqyK8f5FksMBrNg7BdyoC0G0rCE5ux8dGRU5oB14+gb5DMSp2j5NodpAmp4ZdpFbEtBFsrNSJWAtXQrDn4qXIAN0aGgBCCKTjuYFh2FVSIFHGkct3g6FRga7PFacs/tGsW2wZzp0ESjDk+sEf8pwqDagyH/vLN13Orm8T60H4TEPsibJ6QQpsvv2m6RIAz1Q579FbySltmYa6V9L7m1F/KlfpQbZ9qILSNE1Kh9+MUTjvGih2N4M1GYNFy66+9TALA/BNK4fPMPfaFff4mevpmEynxbP3aRDmwBXPSDG0cW/GJ6SAp9+dQdPBpxlLpQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14) by LV4PR03MB8257.namprd03.prod.outlook.com
 (2603:10b6:408:2e1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 02:09:44 +0000
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d]) by CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 02:09:44 +0000
Message-ID: <b61f7b6f-8b9c-4352-bf81-2223463ead30@altera.com>
Date: Wed, 21 Oct 2026 10:09:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/15] arm: socfpga: n5x: enable QSPI mailbox before
 DDR init
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20261016044047.21496-1-chen.huei.lok@altera.com>
 <20261016044047.21496-4-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20261016044047.21496-4-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR03MB959535:EE_|LV4PR03MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e5919c7-226d-47ab-691f-08df2f185f76
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|55112099003|10067099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: hGy6bVkpTR+j5OwXzftRiKlD9MAI3yr481VV/OemK6RAzP8MyPAJT0wkYTA8+bCJVH8LgzjhBPWB8DXqlZkW0op54qZ04sA+3bI+lrYarfzlaShDLjMhzXLI4D7eDAyfzRF0ntEgM/wUDhqiTYTGU/jZx+pcLYY5HMppEBxLeP6lUiU1+ddCkn+/ANlN4GfAmR8bS5+A0l5n6bO2ZpKM96u8XBSK5/70u/y06KQeRAB+PHPpk/Clj0XPWdxFEivtRlmmERYvzABJvVyzSDZqbURvOB0pU7CHmthv1V2XWJlxt2MPsFRLo3rt+46XD2I4KCbngU4aJ0Hnz4NxZvI49s5RvGUgSqB8MBVI5bPtim9+mju6h2IYM11DzX/MnbnQrP0P0OTl5DgaZXT1R2+A+fHMyOpeOTA3nHYk9V8kOP9JBWf1XSybmiCMVvL84okJOZEJmJcb0hQ2ZBv6am9J57f4+gmgygdptEdcj2cA2la7FFofLH9RqM1e83B+BUIlBFyErVzK6n56YUtGAvqnWKOdsZlylinlnX9Sdq8XznXb2xn+ZR4VjNpYTLsx5eOX2vh9RaDcjoSk+7Nz+ydHSb/btYRq0F6Lg9euI89ZlaMs9aFKXXGfkJlYFz5iPrlp2V2O/HGwfm0Z9jHrCDrPHlS7+gqpPEA9VMhxQgXFvoA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR03MB959535.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(55112099003)(10067099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnhNc0E0WUIvOTlDdHZwY1I3a21haERYRU85WjhhcThWclpoNUNlQllxd2JD?=
 =?utf-8?B?ZU5QcDBpd0hmMDJ6VDh2ZG10ckcvZHJJZHR6ZHhvUGNvd0xFZlQ1SCttQlZx?=
 =?utf-8?B?cWdsdTZpSFFIR2JMNkxBc3ExT1FtOHVja2kyV0h4MGtGR29qMlY1eGQzalY0?=
 =?utf-8?B?WlJPakg0WlNyU3BKT1ZEeklTVTh0QW81Tmk5QkZLTldUaDU5WWt6ZUI0WEJi?=
 =?utf-8?B?UWlZeDBCR08ya3pTVXExWlkzRStsUjdMQUpSLy83WGlEelVuWEZwZjhITTVL?=
 =?utf-8?B?bnBicU1oa2d5S0JsRStlWGRod2RqVkpsbGFtR0VzUU9HU0pwUkhZVktJUzNY?=
 =?utf-8?B?MlJqR3ExRVpVakk1SlZCNG9SN0l5NjBOM0hCY2dBUU1obDQ5OHkvRGlUZVNB?=
 =?utf-8?B?ZkU5aTlFUkE0QzUraWVqdjUvcmFpNk9BdHEyTm1lM2dNTTJsUCt3UE1IWXJF?=
 =?utf-8?B?VkpFd0QxOXJaYnZUQjQ4a3BsQTMzQ0dlUnVkcjQ2MExIZUhZTTBuM2toMEp6?=
 =?utf-8?B?VU8xcmc3cDdLSjlDbUZXWDJyb2NXei8ySjkyWUs2VHRWelgxcFRBQnYxakpC?=
 =?utf-8?B?cHdjK2FlemJ1by94OEZWVThGejZsS09na1I3Mmlxd3d0a0kwRkRiL1FKL054?=
 =?utf-8?B?c1k0bTlsOUpBOXpqaDVCajRiN3RYYWpERUgvYy9TUGlQSjg1OW5ibGVlMDFr?=
 =?utf-8?B?dXR3d0FXWi8xVkwzMnhVVG5vVTFTbjJLZDlYYTJMV2p6c25zczRQWWVxRzZV?=
 =?utf-8?B?eCt1eUdBcEhaWVVrVG1jQ1QwZXZTQkRWVFNyR3VwRDZHMVNxSXNFd1ZCMWc5?=
 =?utf-8?B?Rk9KOVd1bitjR1Z5STZOdzFQb2lqT0hIQ1gzOGxNOWd3UjVhZFZTQWF4OG4r?=
 =?utf-8?B?UFRhTzFwL09ncFlCNUdxb3JGQjc2b2dHdEMyN3EyLzBSaHU1VW5mLzE0RDJq?=
 =?utf-8?B?RTRKNm1JcHR2ZVE0VlJXTGZReUVnTmNtVzl5OWt1RFJTUWJXbWJBSXpWYmpr?=
 =?utf-8?B?anNmOXZzM3BHNEM0YzBDZUZTRFlsdzNkMGthYThGSkZyWWxQZkhnNnB1VDNH?=
 =?utf-8?B?dnlkamd5ampvaWRJUjQydW9Ram9DQU8wRTRMZklzQmZ0Zll5dHo0R2kvQ2pl?=
 =?utf-8?B?cFBMNkpKaHJpUW16N1VSajFvaEU5RmhkVGt6ZHRTZ1ArNE9SU25IVDdVNnJn?=
 =?utf-8?B?UUxXbFJFVXVjZnBVaFZuREtjaTcxOTVMRVZCL3VRRGRqaENtNXF3NkpLNi96?=
 =?utf-8?B?cHh4dG4ycW1YRjlBTnFUSWJuSUZkL1NRcW9qRFF5czlEZTVVSlZ3d2tIeTZk?=
 =?utf-8?B?TlZCTGlGdlovblBsSWIxMU9kc1FHMXYvd0VzTXdWOURjNzJpU2N6cVNqdzMx?=
 =?utf-8?B?b3RjeFNWZkNXZ00yS0FYVWY0eEl2bzh2NEJOalNxWnVLNDFKWFZ4akpBVGVV?=
 =?utf-8?B?UldMbERwQzQwRkJ0YjdlZ3RpdXZPTERjVzdETVRXN2tWbWFET1EwZE1NNE80?=
 =?utf-8?B?NTh1bm51OHk2UjF6bUg3aXh0N3ZEYmZzeU5Sa2F6RnNvQnNnS0J6cjNHVHUv?=
 =?utf-8?B?Sk1BMEtRNExZME1MZjdZK1FrUVpxbnllaGRtQWNYMU1iNjNqWmI0T2REemgx?=
 =?utf-8?B?bHRZVTJVMXI1a3A1R0R1eUExTkN2QVBIVzVubTVUMkZxMitrS2UyUTVCVlpy?=
 =?utf-8?B?M2Y0OEJncmhxcUVOS2NOSjRCWkd1RnZNNVZrTzJNQU1PTXRuakQyZ1MwcktC?=
 =?utf-8?B?eWQwQjJ3VWw5a3ZsSXhTS3lEL2oycGc1NitkYVNFTlhuc1JKYjk2a1BNcXBm?=
 =?utf-8?B?L0Robi9YbDgxTUpKSUI0Mk9GSkZERWZ3WFpFN3pFYWxkM3kvRDZRRTVDM2Jh?=
 =?utf-8?B?S2N5M0ZnNUhtVk5oZFdGREprZ3owUC83b2R3bVdocy9ZUEo0b1lGNEdpZTVL?=
 =?utf-8?B?QVdhNDFGVmpDZ21mZnhmOG5SZzNoeW5yTGJOcDMzTUV5SXdLa3FBcTkwelV0?=
 =?utf-8?B?aDNFWXhlR1pLY0FZZ056YXY1bUpjZlZjSksvK3NQdmdPUDhLVGQ5WGovSkJ3?=
 =?utf-8?B?VERqMkhCQ3hvOGdJeEZNVkt3ajlYbVB5cllOWmlqNTQ3L0RjNjZDS2puaDdL?=
 =?utf-8?B?RHFSUzgrNDRUV2RXb0pwYjM0ZkpyWmh1bG44bjdKVGVyUDkzb2pLZXBwTncr?=
 =?utf-8?B?dm84SXVFd1c4T24yd25IbW4reHBSRzlFbDhJVEszV0pQSDU5QnhCeHdsQVhT?=
 =?utf-8?B?dVo2TWd3UzBadGZMZlp1NnlOd01UaEVVbmZQNStOU1ZDM3hERCtHQjVqUHZ0?=
 =?utf-8?B?N095czcycGpKbDhiamtUdjRmaW0xM3dsOFhVUHpSVS9wQTBLRGNrUT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5919c7-226d-47ab-691f-08df2f185f76
X-MS-Exchange-CrossTenant-AuthSource: CHBPR03MB959535.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:09:43.9813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTwMev1LzneQ92oTgXYO3jXtfTojGmTeSh6lmiUSEqAbScaPFyhSu22LZjn1HsXOfcFhdRVWrIDkirC9FLgUjxpDyuYaAR+21vujpZnydmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8257
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
> Move the mbox_qspi_open() call ahead of DRAM initialization so the QSPI
> controller is handed over to the HPS and its reference clock is
> configured before the DDR retention path reads the calibration backup
> from QSPI during DDR init.
>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>   arch/arm/mach-socfpga/spl_n5x.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
> index 381aca6d32f..bb2d6187ffc 100644
> --- a/arch/arm/mach-socfpga/spl_n5x.c
> +++ b/arch/arm/mach-socfpga/spl_n5x.c
> @@ -105,6 +105,9 @@ void board_init_f(ulong dummy)
>   		hang();
>   	}
>   
> +	if (IS_ENABLED(CONFIG_CADENCE_QSPI))
> +		mbox_qspi_open();
> +
>   #if CONFIG_IS_ENABLED(ALTERA_SDRAM)
>   	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
>   	if (ret) {
> @@ -112,8 +115,4 @@ void board_init_f(ulong dummy)
>   		hang();
>   	}
>   #endif
> -
> -#ifdef CONFIG_CADENCE_QSPI
> -	mbox_qspi_open();
> -#endif
>   }


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

