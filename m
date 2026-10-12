Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6A1CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 07:47:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C84A6062D;
	Mon, 12 Oct 2026 07:47:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x1819rZj2CZY; Mon, 12 Oct 2026 07:47:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2338660618
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791791275;
	b=Y3ZGbUKhwOp9yQ2Rqo9i38c+9Cp2pydCKSS5urIQYcPPo1xmDxXGWaP8hxLzqlQf2EyV
	 //KQsjhBp8Rohn5aLlPyck6Ye+3m0GBDw1fn0KgLGhawS/aVfwbjdALCOgq2Vn/xyV+1O
	 WpBJZeBWhWOYrTesWUJLwKLyTx80Z7Reco+D9IDKkfYeyjiSbn2/vQGo+gL0avKlCHyvh
	 MFxULcs11PUjD8vRmZnqtOnpYAZoKw0sJDwbxX4U9RaM1LoxqIzrCW0P6fWA75dMoOdFG
	 Kpmu/HBqqDFUccFD6QQ6kVzrfyygWD0WZjZl9+6CKH1jSBM2vNrMqizqCqG3SBsUImA==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791791275;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:Content-Language:To:Cc:
	 From:Subject:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
	 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
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
	bh=U3XNaY5ylKDwgG1Pg/zwLoBd1Q/WzABiFfL0lNDA8ZU=;
	b=Pm3y+IEwqY8J4Mxba/HcuJIkr1ieP3vf89zaO+1tIGu4ZV4mSxCSWqQdMzUOqUQA6UUy
	 EPoAENcczT2pVwJK7UVyoPnO6qLaH5AdQ0rcy+MVcE61/SzhtIy8qnhyAaPsGrqnlynW4
	 b0zNKgqHcKus3vGoVVosdCzqvkNPDT1sYcB3uTTs7zdDpOjbOAt1JVhfiKwrbBgzOSddb
	 wcPh63p3SmdLzODKOCEZBXq/hg0qrPEJWTr/l8aOQv8uI/hnWBf3JRBY+W7CXUyDAPnrQ
	 /h/ll7nGzs46vZDVHsk/O3XFMjsTyWB0Muo45qtveQgspvmGmUFnt3h4RggDN10z1UQ==
ARC-Authentication-Results: i=4; smtp3.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=qFQaWdhi;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=qFQaWdhi;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791791275;
	bh=U3XNaY5ylKDwgG1Pg/zwLoBd1Q/WzABiFfL0lNDA8ZU=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rOQXge8LMbBYalpBzZ6AgM4flNTBiemlW1l/LgIi845JZ6HeSwu8o5dFalXE5NNRM
	 fD6xGRgdBPuLWMQG6HtQNms7SiEJbQ1VV7qXhyYqaoXqEO2hirKiGhtUQKFTKt8d7f
	 dbGnnrQ+WEd6XAQj66RfFI9vyTVh8Fy1x1kcES3y9ZjOVNxPXlxiIssoSri8SSGal0
	 23VYzLamuKAu1e+kv6TjQGAWSNAabHD/QUtdhPHmZZ+InKFcnMGGfonRLYK3WxwI40
	 qIH7TyS10bfC3DSU5i6sC1FmlsUxeNXYURDXYy3GqgfHCiumfMjCVLMyx3qHV9tdBV
	 iNNDUEYQOW4Kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2338660618;
	Mon, 12 Oct 2026 07:47:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CAD069CF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:47:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B0A2460618
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:47:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Gr17WwleXPw for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 07:47:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 42C7F605F4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791791272;
 b=PPanntOadaRSKf8Wl3wYxhqlsoOyCS4cCA6tVQsHcKUp/xPnHuIsowPIH4rzplQn9rlM
 AKr0ewS0ggOzm7jCjdtnkenGuk989zunRDHgta1DQ58biNtnfG5gwa1gOJur6aVfBUKSK
 gyAyg1JOyTsRAPFMSqkSqL5dEZrjysL9oci74SLdirLSNXJsFXuvxYftaz+tbpHpsG1Yv
 rokKFa30prdkHlHG3CWqh1JYH7oQb8+a+IOXe1R1py0tFyWU4Enj2DVFrEKP05g3iGf7x
 mJXXitgyag9TZp0/XfzUv2WJ8xI0LBAS8Hf6QPDidCRMga5f3WZxaPSqCAP2wqLVbpQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791791272;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:Content-Language:To:Cc:From:Subject:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=U3XNaY5ylKDwgG1Pg/zwLoBd1Q/WzABiFfL0lNDA8ZU=;
 b=HLn6D2rlskMVTpw0SY5n9DlA/iaKBmeA91oaiwjt2XBnMABy86fzHMYbKWIAic/G3T2f
 xtIienjbtFVlrDxE1ltN4jxhLXmongNquVtZpHnRlKzTkUdzWFIUljhaded6k++Us9Gbb
 JEVHQy2STcx43qjr85YFdSXSKCKpc1QpSVGAxldua6QYkWiYx9VLqaiP1yz9QWLQax3QH
 8yBA7Eqi01g8cMdh/3kWKMYftEXHhnhsEhhq90qCrqOtVSn45Pn2X7LbjDXankXQzferf
 kZu8vMRnuone+04UeBPZ+bmKz9vQuX4exyQZ5CR4C4hMRklzAAEnLB/bXbJac44WTEQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=qFQaWdhi; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=qFQaWdhi; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=qFQaWdhi; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=qFQaWdhi
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 42C7F605F4
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:47:51 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Qoa6mrFifCCzks8E+Sx+8zEKU6U8WcsyryYb+f/HRkOlccD+PO5WaQXHPZE4HmBiU5QJzz9pUlUG+g2rpWEV/dTkiw0KEAFh10oiHWQTaTTsLHpaziV6IOkU39M7U+XrQTfrt5mjl9Zb8awY9oA9JyykJ+c69ahKwAQHAqw+7jqfqCy2QUo6M+xuLkMcZJ4zw562mWwbJ7dDBcEMmL7oTcjTOF7xQgGEkGhfdd7lLpNbgvMdlJvvawrUfyrEXxe8KKyKBxr7k9v424lRg6QjhNmLA09iFFs5K4XsIfedbq9hF6dPcAShX5g7yY+W5xxlPfazy/9xNY0eMVfW4FCkLg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3XNaY5ylKDwgG1Pg/zwLoBd1Q/WzABiFfL0lNDA8ZU=;
 b=whX8oqFVWPlLqb5ngX33qVSkFhW/vul2vcwi9qY7928Tlul4xRPCKNDi9+XV0D7xuH+E93zJuK+ipacvDvl6lNikeKlbaKhLgVHhMcVRPb3MSH32JeQaF2XBPUuXzFPoOmA7FqRvGFVvbLdxEHxG6Xi8DIbdaDxEq4/kvhbw+N4Dl2LllrqoYCoHLvjCY8tgxm/6ct2yBif3gQ9cw3nZEVJDg20Cepl/zUFb5xH4QgIzD1XJkGUHX+fl/Hl+mWg3jIu5NhB/OuhxEOBDoNsDtwiG2HHgyyHjC0VK/t5+JHteSzvcA2tCFVXDYby2Wr0Yqxae3oN7DHApgmVe9rPo5Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3XNaY5ylKDwgG1Pg/zwLoBd1Q/WzABiFfL0lNDA8ZU=;
 b=qFQaWdhiYbMsHWeBJTsOYwRj73lE9H/yK71o3LxZvac6r3zQxoxkCtLLl1U+S9jMEZYiB3Iay+B0gcI8cJrVZStdLGZLY4uPFs9Fhy4aQBIUmgGYFx42zE8QICqUpskc9yVgAQBmDkd6kV5MDyT15IJshH8BWdWl5EKXWIHbinQ=
Received: from PR1P264CA0198.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34d::9)
 by AMBPR08MB544735.eurprd08.prod.outlook.com (2603:10a6:20b:7af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Mon, 12 Oct
 2026 07:47:45 +0000
Received: from MI3PEPF00008494.eurprd03.prod.outlook.com
 (2603:10a6:102:34d:cafe::68) by PR1P264CA0198.outlook.office365.com
 (2603:10a6:102:34d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 07:47:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008494.mail.protection.outlook.com (10.167.240.155) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Mon, 12 Oct 2026 07:47:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipKQvHz37PesxqqelqmZTr1DSOPXiISxmDb6O/YrQ1cRhDmhqbamhR3CZnygN5URHuIiJ2zTVvVLeMMAEY06r6cNzU/eVWoWnUKMHpOs2OiUaN1k9vG404K/iIQE/aQZpc4AVg16QTzu/Ydv88pf96WA2GMxy997a/j/T2MfAI8NamjsPCrPngM9CiZNUUN9kA4ueQO1ek3es1f5gyR2v5Lo2t6MeHILUoRBEToYJYf2oOXONB4F/JE3TfcmPAQXhV3W4r1cVEEMZJW5zAjEURq80neKI7g/HO8yBMAXlFtwwW5NbE2d+GE9nJtMtt87M0q2BuXA3oE2uIknhWFk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3XNaY5ylKDwgG1Pg/zwLoBd1Q/WzABiFfL0lNDA8ZU=;
 b=aY9P5L+hhJnplOcR+mM4z10PHvwIdM10LugPpOPbdxyGPpALe+tVmPG+T0Y0h7fZ0aLaTyc870qTig8f28af2duKhlZzWhz4UigooN2go8EMEPQr7/idP4z8J1akaQOVFDWb6gYzPvcixE85rTUfRMMahntE3Der9MCzTfbCHQANCBjwwCLqL9QZRBztSORhOZzMUJrsfDqFf9eknEtWwmVRQegTNXDToTrFfhiX+q6029Unbk7Njgs8XIibsQ/JLrodfcCMxnL0I7Lx3LQzki3z+VDtX/zVZN+aIMygvkCNpNKw1AzJpPz3uzzhBbe1XkcWCkF52mGoZGTnbIZXvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3XNaY5ylKDwgG1Pg/zwLoBd1Q/WzABiFfL0lNDA8ZU=;
 b=qFQaWdhiYbMsHWeBJTsOYwRj73lE9H/yK71o3LxZvac6r3zQxoxkCtLLl1U+S9jMEZYiB3Iay+B0gcI8cJrVZStdLGZLY4uPFs9Fhy4aQBIUmgGYFx42zE8QICqUpskc9yVgAQBmDkd6kV5MDyT15IJshH8BWdWl5EKXWIHbinQ=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GV2PR08MB11608.eurprd08.prod.outlook.com
 (2603:10a6:150:2cd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Mon, 12 Oct
 2026 07:47:06 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0522.006; Mon, 12 Oct 2026
 07:47:06 +0000
Message-ID: <e38b2ce1-a74b-4266-8d34-8a8eeb9981c6@arm.com>
Date: Mon, 12 Oct 2026 09:47:05 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 nd <nd@arm.com>
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Please pull net-next-20261009 [corrected]
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::8) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GV2PR08MB11608:EE_|MI3PEPF00008494:EE_|AMBPR08MB544735:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a7d979-9b30-453a-1d44-08df28351a4c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|10067099003|18002099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: UTE7UsUmFvRaHKyYCTnnhZ76dBfeNH2A3rxxIgAbfECv5d3vH9u/AcwDtrqLNtQmQdCiM51k57WVCe/hwgXsR1JoSflUgyUDKZT7Qn+XQfd2CsY1ME8lbCCNN3CYL7r0DMkAz4mNULiUHetvfUqzzjaCBn56EGBU3FNYdEIGWMq7Lqzrb+8Vo+0zNlnNwDASB5PsdHhoyfxoY77qyMXY8RY6wi1sBp+7F/QKqe7/Wki1xm/Wp12AkE8k6AHuV/VFPxiNVHXuivEFRCHShu2j1SlOChp3P11fxLutUTxclXBgamLi/Pr5HORSjvA9EcKDBQVLjMoOOHSPK02zDsTmmaJZ1xurZhG+0oTDzHVp2aLRFzstyFHh73omsfukqR/x9YT/Hk2ZnUxMUSzKL2NFICEj+IVSMXd5Ls2WJtK0lKz/l14py6+FQf4ZyEeYqZORaedd+f5/bzy4vQYAxLkxvJxFBCRlNXZBXhLfOmRiICmH3Ux0GIGBA4lxwnnhfcQyYQW9a5e6df3VaDErfA/s686VhS/f0X0sfIem+J3CYNkIu/ditKFV4nsfJ4Pg/CHza/bFli66XKwKpuZc8QP3q7U5TIox/+32U5vI4GQhGIc=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(18002099003)(3023799007)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 24PAQPYuJDCuJbDY9QVqLRNVTr1NLeNKOhfZcAFTyUf7VHGyMz6zC1MBsZ68MsTtp6vVbpk1UTYTBIQ9+zCfMrpkSLoLTIJDJTy2brBvtWOsvKhreN4WCqPlvALJkQ1uwbdL3Y+OK4jCvjf7egWdBe1s2LMxrodXoHrg073TmGSTZPixx8bYXD6myGHelnLb8GCppn2S0TH76XWv10idUdwoq6V0/ce6uO7LFdZEncOmXXEswkBv1VGlBjUKoIUgHVA8xcl53YfNOfndN0Hc6YEl27RMfJoHu3irFp6MyaLaHnpyPFODuVj6x64JGj3guaUR9sNYcSG+qFnmexiMtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11608
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008494.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e26f2052-d37a-4718-9e6d-08df2835035e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|14060799003|23010399003|36860700016|1800799024|376014|35042699022|6133799003|10067099003|18002099003|13003099007|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: EEYOXa7SXkDZxavsLDNxVySoYvjrH8QSU3nlHgZ+Y+Mps2U5xhVQNxty2E+PRdcQL9pczQqUeqPQjgUY5FoTMcDeTgyGE1GG16LZSeIODaaSUlm6C6ulB/8rLIVsUWIar6UCmUM9SEMYjZNMnua274QYuzqo8Rh5RyFSft3NUlbdPNTe384QF0uQLW2Vkg4QeYjPO99BYCHx3o+5mBH/KU6hMZo2P65NCZT/q+nSgHi9ALbqS7xHH5UNVSa+ccolUHGF0tK91VBu0Q9z8TkXj1fU1OKBZPtuKdK0BpDdy5+NzJIvOM4SofjqzTu1uULgJZDv21TaQnSGaGuM3aJZk9puhXHcIOBs8Ndhp0qzITA26fl3aGmDI05ckVrE026eqd1eQJx11ZVVYMxIXnP6LwN/xxSGHWTzEP30c8if3VTXritL/FAGvbokSOUxI4LSsT+/ErV49Gc14uBsdzsNBPzAwOz45yWX9GXHNEc3E4z/1P0P3DAIbYWGRr2Cnv0ACx9LH6bwwlTH++prebLX1+/z7ITa3VgTQGw/2lwAtNQ+ICYdKVq5yC0ZhnlpSqq1e8JL4LElh4RFAggrqG/W1pZUn9B+X8q7w8vRZSm2KfOXeppxOMJGHSqXrqjZO55mMc6Y4y/lBTads/VbfyihkA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(14060799003)(23010399003)(36860700016)(1800799024)(376014)(35042699022)(6133799003)(10067099003)(18002099003)(13003099007)(3023799007)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: soBWdu+6wu4FWO5jS1ZixWuyv68u69maz32NSC7W9HKsdd/9ogxBSARio/TQfteThA8W/tYMyFYH6Waa7urpJl9i9FwSazEbJPpTLJGaXBfhW9KxRcytSYK/XaHvDRxV2OD2b2RAj72IRUxLglw+DZeuqvxV6ds+E5/73LzB6NSY+3B0mhpvCf1yqgf1EiKF5vBLrwcVUCxmtjILL3KSi/0O+G2i4bkt+adO8Kc7fzLoOtdq60StqVd9pCbfgLOF+UPafJ/SIT7jzOzFf2IukvjahKNP26O2wkoX5hm0fa4Xr1f+/nGOC0RojOYqKex4Q0Ne37ocUlbCIa7/zVLYmvekSj8bAqwznIwlNmCBKzh4Mk+pAr1FtyJkZorvrAhJ+thdHcYysP2sXtOEgJWyc+QRUE78npoG+drmUHOda3rvqgFtmJVAgMQC9jenR4vX
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 07:47:44.8189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a7d979-9b30-453a-1d44-08df28351a4c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008494.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB544735
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

Hi Tom,

The following changes since commit ed869863c7e2aca50d57a05d843830dd843138c4:

  Merge tag 'u-boot-marvell-next-20261005' of https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell into next (2026-10-05 10:40:38 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git/ tags/net-next-20261009

for you to fetch changes up to 28ddd369e2f7199539cdefe22ce014c592b890bd:

  net: dwc_eth_qos: spacemit: add support for K3 SoC (2026-10-09 18:58:10 +0200)

*** Please note ***

Commit "qemu-xtensa: Increase the U-Boot memory reservation" fixes a build
error detected by CI that would otherwise be caused by "net: e1000: use all
RX descriptors". I did NOT send that one out for review to avoid delaying
this pull request, but if you'd like me to do otherwise just let me know.

Similarly, the test added by "test: net: cover lwIP DHCP autoload handoff"
initally failed CI and I incorporated my own fix (see the commit
description).

----------------------------------------------------------------
Pull request net-next 20261009.

net-legacy:
- dhcp6 use link local address
- fix UDP checksum check for odd-length packets

net-lwip:
- restore BOOTP, DHCPv4 boot policy and PXE parity

net:
- e1000: use all RX descriptors
- net: fsl_ls_mdio: add match fsl,fman-memac-mdio
- phy: prioritize GMII2RGMII bridge over DM-bound PHY lookup
- dwc_eth_qos: bring PHY up before triggering DMA soft reset
- pxe_utils: Fix buffer overflow in pxe_label.num
- pxe_utils: Fix leak and double free when using fallback
- phy: dp83867: fix register number for extended read/write
- designware: Fix MDIO bus getting bound multiple times
- mdio-mux: Recover gracefully from bad parents
- dwc_eth_qos_rockchip: Fix use of mii/mdio commands
- eth-phy: Add reset control support
- dwc_eth_qos: spacemit: add support for K3 SoC

----------------------------------------------------------------
James Hilliard (20):
      net: lwip: bound NFS filename parsing and release its copy
      net: preserve the autoload value across dhcp_run
      net: lwip: finish DHCP before starting autoload
      test: net: cover lwIP DHCP autoload handoff
      net: lwip: add a hook before accepting DHCP acknowledgements
      net: lwip: carry DHCP boot options into the environment
      test: net: exercise lwIP DHCP boot option handling
      net: lwip: export DHCP DNS settings without a resolver
      net: lwip: honor configured DHCP boot-server preferences
      net: lwip: support PXE client and configuration options
      net: cache accepted DHCP acknowledgements for EFI PXE consumers
      net: lwip: honor DHCP timing controls and request header fields
      net: lwip: add a hook before parsing DHCP replies
      net: lwip: accept direct ProxyDHCP replies without a lease
      net: lwip: retain boot metadata from the selected DHCP offer
      net: lwip: retry DHCP acquisition using the network failure policy
      test: net: exercise lwIP ProxyDHCP ordering and validation
      net: lwip: separate DHCP exchange from boot configuration
      net: lwip: support standalone BOOTP
      test: net: exercise lwIP standalone BOOTP

Jerome Forissier (1):
      qemu-xtensa: Increase the U-Boot memory reservation

Jonas Karlman (4):
      net: dwc_eth_qos_rockchip: Relax dependency on reset controls
      net: dwc_eth_qos_rockchip: Do not keep reset controls asserted
      net: eth-phy: Refactor DM_GPIO guard
      net: eth-phy: Add reset control support

Mingtian Li (1):
      net: fix UDP checksum check for odd-length packets

Nora Schiffer (1):
      net: phy: dp83867: fix register number for extended read/write

Pranav Tilak (1):
      net: phy: prioritize GMII2RGMII bridge over DM-bound PHY lookup

Sean Anderson (4):
      net: designware: Use if instead of #if for DM_MDIO
      net: designware: Fix MDIO bus getting bound multiple times
      net: mdio-mux: Don't crash if our parent never shows up
      net: mdio-mux: Remove ourselves when our parent is removed

Suraj Kakade (2):
      boot: pxe_utils: Fix buffer overflow in pxe_label.num
      boot: pxe_utils: Fix leak and double free when using fallback

Vincent Jardin (1):
      net: fsl_ls_mdio: add match fsl,fman-memac-mdio

Vitaliy Sochnev (1):
      net: e1000: use all RX descriptors

Yixun Lan (1):
      net: dwc_eth_qos: spacemit: add support for K3 SoC

Yuxiao Zhang (1):
      net: dhcp6 use link local address

kongchen (2):
      net: dwc_eth_qos: bring PHY up before triggering DMA soft reset
      net: phy: add support for Maxio MAE0621A Ethernet PHYs

 boot/pxe_utils.c                     |    4 +-
 cmd/Kconfig                          |   59 +-
 cmd/lwip/Makefile                    |    1 +
 cmd/lwip/bootp.c                     |    8 +
 configs/qemu-xtensa-dc233c_defconfig |    2 +-
 doc/usage/cmd/sntp.rst               |    4 +-
 drivers/net/Kconfig                  |    9 +
 drivers/net/Makefile                 |    1 +
 drivers/net/designware.c             |   71 +--
 drivers/net/designware.h             |    1 +
 drivers/net/dwc_eth_qos.c            |   57 +-
 drivers/net/dwc_eth_qos.h            |    1 +
 drivers/net/dwc_eth_qos_rockchip.c   |   21 +-
 drivers/net/dwc_eth_qos_spacemit.c   |  313 ++++++++++
 drivers/net/dwmac_meson8b.c          |    3 +
 drivers/net/dwmac_s700.c             |    3 +
 drivers/net/dwmac_socfpga.c          |    3 +
 drivers/net/dwmac_thead.c            |    3 +
 drivers/net/e1000.c                  |   87 ++-
 drivers/net/eth-phy-uclass.c         |   38 +-
 drivers/net/fsl_ls_mdio.c            |    2 +
 drivers/net/gmac_rockchip.c          |    3 +
 drivers/net/phy/Kconfig              |    8 +
 drivers/net/phy/Makefile             |    1 +
 drivers/net/phy/dp83867.c            |    4 +-
 drivers/net/phy/maxio.c              |  228 +++++++
 drivers/net/phy/phy.c                |   12 +-
 include/efi_loader.h                 |    7 +-
 include/net-common.h                 |    8 +-
 include/net-lwip.h                   |    1 +
 include/pxe_utils.h                  |    2 +-
 lib/efi_loader/efi_net.c             |   72 ++-
 lib/lwip/lwip/src/core/ipv4/dhcp.c   |   39 +-
 lib/lwip/lwip/src/include/lwip/opt.h |   67 ++
 lib/lwip/u-boot/lwip-dhcp.h          |   28 +
 lib/lwip/u-boot/lwipopts.h           |   78 ++-
 net/Kconfig                          |   43 +-
 net/bootp.c                          |    6 +-
 net/lwip/Makefile                    |    4 +-
 net/lwip/dhcp.c                      | 1106 +++++++++++++++++++++++++++++++---
 net/lwip/net-lwip.c                  |    6 +-
 net/lwip/nfs.c                       |   68 +--
 net/mdio-mux-uclass.c                |   39 ++
 net/net-common.c                     |   22 +-
 net/net.c                            |    3 +-
 net/net6.c                           |   25 +-
 test/dm/Makefile                     |   12 +
 test/dm/lwip.c                       |    2 +
 test/dm/lwip_bootp.c                 |  573 ++++++++++++++++++
 test/dm/lwip_dhcp.c                  |  364 +++++++++++
 test/dm/lwip_dhcp_options.c          |  691 +++++++++++++++++++++
 test/dm/lwip_dhcp_policy.c           |  286 +++++++++
 test/dm/lwip_dhcp_proxy.c            |  461 ++++++++++++++
 test/dm/lwip_nfs.c                   |   61 ++
 test/dm/nfs.c                        |    3 +-
 55 files changed, 4696 insertions(+), 328 deletions(-)
 create mode 100644 cmd/lwip/bootp.c
 create mode 100644 drivers/net/dwc_eth_qos_spacemit.c
 create mode 100644 drivers/net/phy/maxio.c
 create mode 100644 lib/lwip/u-boot/lwip-dhcp.h
 create mode 100644 test/dm/lwip_bootp.c
 create mode 100644 test/dm/lwip_dhcp.c
 create mode 100644 test/dm/lwip_dhcp_options.c
 create mode 100644 test/dm/lwip_dhcp_policy.c
 create mode 100644 test/dm/lwip_dhcp_proxy.c
 create mode 100644 test/dm/lwip_nfs.c

CI link: https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/pipelines/1527

Thanks,
-- 
Jerome
