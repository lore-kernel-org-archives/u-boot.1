Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1960C606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 02:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SvdnIi8v;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=QqrqFUyb
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4585407F0;
	Wed, 21 Oct 2026 02:23:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1MX0QaHGHlD0; Wed, 21 Oct 2026 02:23:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2D720407B2
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792549388;
	b=Gx8GtpDX5xgeMerTFsaUnmpSVfvvMJGSTP6H08U/lQFUrK9GQsnVIP6n+gtUr3TWAKR7
	 jTx5MZ3mJO9hNKKD9DIOaYPLt3RlrhOkLXFe6cSIb5D7lBm85xkZu2P07jHZBld6znbMc
	 PG0DI/D0kK4blpZubbX4sYilZu/JhpHrxgn+/covcI5EVmHGzAS7GHAg7+FPus/CGPTJH
	 9yWXTpe2sdQ6blM5tE2iBDyDenO46SxDvrNJAUjWDewhJaa3teXwEez3pQy7RUu1OshVN
	 T0sbla6UR0UCumQvCRO5y3IHn/IYpYH5E1LqfNiueRJNNKmHsgi2TsQAFXzeXRrNrMA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792549388;
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
	bh=5jIpiUKLTXVTiYbhnodvy0unPgJPLrHNbY/qk32A2pE=;
	b=hKCZ+9F9N+NzrF78olJPDojNIciyC2SKXn0s7xEsZFGjaFRNLlHsYhXVgR8grO/o1f8s
	 YQJo7XLKjap0gEvzS/Rg1LRqG4jdraAlSkIOyJFL2ncFsuOEskLbPsNsMQDnZT2x3rtN6
	 qSWCfVfXEY/YbJr7u+hob/fS1Cbc1Ja8HRrvQtMqCVWcmiucLZaylWYQHc74n9cVN/Vwh
	 /Q/LFDL810Q+mbsbdKC9Vvhg+ixgOn5b8348FcVf9ZX4qksU+fHgRJry+0jgfCwLuZ463
	 99knfDoODcz8TulWLmGmvjiUPAcyN39jf1X5uGHE2qB/RE7uQn5IcSzxto/RqNoFUaQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792549388;
	bh=5jIpiUKLTXVTiYbhnodvy0unPgJPLrHNbY/qk32A2pE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SvdnIi8vlhgCnyLXQ0x0oupEWfy8Qx6ECuydS96iIg+fd3MSs/t94ECyhcG055Tkf
	 mH8dpL5WqxVghzstaxEefJiGysIFu8/i5wNQxRodoHugyc98MSdK+xXvPQlTVAjLof
	 nkYuYoKcIuWSXC+o2LC8L6OY/KZK52J5Zih5Eoihng/7SVJOvCNIMyGfIFHZdu2PqT
	 GDBPDLJz4VdT42ug2EEg+b+A3F59oqXQoNsS+0SRkLXfM/hRSU95ND/UKOpj//2sbV
	 ei8tZCrxUsJ9/UupSHjRbz/DkD3iNV9bwcsVFeac/cA4LLiPDuxAOm+O6cjaeDhTyq
	 UHNofObChTMgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D720407B2;
	Wed, 21 Oct 2026 02:23:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 361CF1AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:23:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1CD466074D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:23:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A3xPRd8iLJ8M for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 02:23:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A81CB6070C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792549386;
 b=sC2mlOXeZRxXK10WR7Iie3BJzZIyyg8k3Y8spUelk1YFcSBKEb6P/dn4TA/phpNHxn0I
 wqOMad3LLpkzkkbgikpCNkNc+/GGrRo3RoBt7zOjw3T1A+hA/uZN6pNkwE50846bJp1Nm
 ZrleSDq7QHfCDW7lOCyEQw3Mr+zPsQqxGituVUaU/OZ/qzvuFrP58xySm1AWRHzB7iN0y
 j6WvJU+U00c56RHm00WTGnxUKliGvRhOh1SpMZtAFNGyhgrVfAm8jFm7QXEORby8oJtBI
 ijz+XJUrvH+PqAYme3FAm1RwP/kki3CWjJgfOcqgN4ofs6o231I72qlMLXPF/0+tClQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792549386;
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
 bh=5jIpiUKLTXVTiYbhnodvy0unPgJPLrHNbY/qk32A2pE=;
 b=fDmigKzqlIH5gQ86+DrnleDTF0a38pPPLLFCm1/AAaNgGX+K4hPuSaDfn7iSR/jPw6jR
 KM/oglUHLp8L5LzpbPN4AdXjNMngzWdzQAewISO1Cv478viNCvPwWZMag8+zfJHj1a/5k
 y4ncyO924+2sV3zZYHQWC7rWGrrs6TSnpIaImorEBYlKl8ZreC+jr/xpwh+wXlVAYPufZ
 2B2rCbaOD83SDpfVCa4U3UBhdBj7l85TkL1h/d96SI9nHeu2zaB0NiBziZgj3xHnmBlWw
 jnfvTiYkwRi8ZyUchfrun8pep+ke7x7nBILyAQBMWh0Uo+lwIUANAvx0AGy2DXOE59Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=QqrqFUyb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=tien.fong.chee@altera.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=QqrqFUyb
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A81CB6070C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:23:05 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81A11844F6; Wed, 21 Oct 2026 04:23:03 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 669598056B
 for <u-boot@lists.denx.de>; Wed, 21 Oct 2026 04:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOe/zTN89mLzWTyaTeLlg5/E6mO/Sj+vfRHvhcds+0JZak073W8fYeVPRRdAGXbPTs1R2r0/A1yb6++HUZrnUgcWqSddj/CRn+LfoX9WuD8eI7sw0v1v1d7QHvVt1r7FhRI/v4acDrMH/0/+BcoDFeLPBtWjUJ2t60Q3eEE3NLCLWvGkj9Broez4e41ce+AZzoDVvxCKTlqiCPbZYKOjDXNXEK+n+aLNJFKZtcFXteCpZIT2F2Jmwgb/vx1HOx5JkBGDGT1CqHeswhWBQ98yBKJAC6c9CrnYyqO3Ree53LFrpArSqHZnCfQQqiYKKEuu53HHjC83I2ZZjSYGZNPreA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jIpiUKLTXVTiYbhnodvy0unPgJPLrHNbY/qk32A2pE=;
 b=SHDbCkiZeKW29lGHzKIwGDMkleIxIQb2zSNlpiho8UUElE90octQt4vd7HPuwT26O4Ke+u9BacMGptT5fln+/vAcLqKssD9NLm3DAOped44cAziCme0lpymdSheus3qIq7IXXGeDb9KKTlUr1b/GI9RztnGn+hV8sjmXVX7T6IDBQzPSstN5scXpfyYX2NMJNsNtXoR/x7iP2JJAznDXZyHDMqBqEJwtgmivlQSJ13oYTBV2khHKvIfT6oFSc+1SdB6/JT1KYrNqVNwtcOWOewvbjv3tIjji9syzBQbyWls4r6aOrulMHUqk+bYQTiNJz6tCatJejSTsPFnWDD8CBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jIpiUKLTXVTiYbhnodvy0unPgJPLrHNbY/qk32A2pE=;
 b=QqrqFUybAkhG7fSNgBkaIRCJUTTkjnxRIKOU4OSSgMGSyDoEOFIksHaCOfSwE4TVGqYORbJzxEOxlan3g14NrOxh5UnGWiv/HAnWq+d3/ogRZxpAnMHX20ycxqInz4uaOblORsL4H/PTvo2zxhyM8By1GWJZZ6ogcXlwJtcAnW68H3C24e5v/wI7x9uL51jU/A6zWFb0yoivyhSLAinTz/4L1TyYr0VUBJRzR9Q1TUR0ughAO9rGM+qH5bomogfAphEJUsKwDfsVh185+ipnkuTWKwlSLW7MBVkuf5oR7760Pt4QIu9xPIfas/TBLcsRICP0QexGin4OGG8CgeCpWg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14) by CH7PR03MB7833.namprd03.prod.outlook.com
 (2603:10b6:610:249::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 02:22:54 +0000
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d]) by CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 02:22:54 +0000
Message-ID: <45b69d50-0ef2-49db-8f88-2f71db77b4a6@altera.com>
Date: Wed, 21 Oct 2026 10:22:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/15] ddr: altera: n5x: return error on invalid DDR
 controller type
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20261016044047.21496-1-chen.huei.lok@altera.com>
 <20261016044047.21496-10-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20261016044047.21496-10-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR03MB959535:EE_|CH7PR03MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c6cfc7-7935-44a6-9937-08df2f1a3684
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: GsuXxGyoDQ9Nu9ahh1TAafRj1jC+VnGUI9Ro+rY7kzHejUEmf1GWC0NFUZhdXOUe/vt1PxgTA5J6j2NWwQ/eeyV2B3smYXzn4WCw3km4fnJnPTDkR45YYfw6wAofLprB0aR0El5+7sSQ8vCrNMwjMI8JAGoXY8+g8ik8cOj9bZd2mKhe4PRL80ckIjrrDGnI4G2qiDc1MlZtHnSCx0gWBK6ZaGECBXPV01fwdxu12HpsMqCQPQzrqZMUvLMoZyeZWZvoH86Qo/9t482iPF3tDmppX1GFoUH9TiWImgx3slmIGTfJAtfCufRzYG8cLbGARY8mMcfmorUqHz+fq0gio6wumnHvYiGYkEELVSxYg+kbQxjJO3bfrfWs7Pmoj5BWzkotvrzJ4rDwEusAIwoSuAA/Nk3S/qfZEoUybwpX/o1V2wFH1hpwHAodVhrrhCIwz9RZZaTiPyE9mYa2lDQOymkg24OHERVYughp45FGNSZca0XkRGmownWKn59dOvruUHsK0RbjF2xHtbZ/eKR0sxKIITqkm0hdjzxTKD2klsoEGdgf0rm3cLK/biB2dAD8CGjFPXvtzkwnbFCFg0Od68mzZIHc44xeir3meXsfs8z2Mrm2MM+OaZ0B/Ivptfv1DC/M/j+fckbK0RRcFAIjCIky063va+bCGEqv53HT1Vs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR03MB959535.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(55112099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWNyOFdrVTQ4Qm5iOHVPRUVpNDFQQVltQnoxNVNLbjZTa3NYQVVZMkNxbDFu?=
 =?utf-8?B?d0hTSnJMa3BsWDJKNlFlUnIremNVRXR5Wk0wcG5BdHhHSXNlcDlheTdiVmdP?=
 =?utf-8?B?U1grbVFVb3dBRVNCTkRpdFFkTWowRDlqaEFHazVxb1VRR1pDUjNpdllBWjVP?=
 =?utf-8?B?ZGdBMFg1a0NXcnFxNEVzMUJhZEFEMGF0UmQ3S1Q5ZVU4d2NZS1ZVbURKbUtu?=
 =?utf-8?B?aE1RdS9OYzZ1RGk1cHM3T0E3SE9OSjJTMmYzaG4xZlpFNG9PK0FuS2ZsTmM2?=
 =?utf-8?B?bGNBbWJXdEU2YlF1TnIxclh0S0RiTkRhN1ZJR0xBSG9PT21RWGNrdWN3aEh0?=
 =?utf-8?B?cGFBTjdHKzJuUlFUOWlyQkZIczVoR3hVa2EwS21XV2RxbjdsSG1TTlZHZU0z?=
 =?utf-8?B?QXZoZkxhaUJYTERkb25YOU5DblE5STBZK05hWFBQNWxaMTMrVk8wRjlmcUU1?=
 =?utf-8?B?bXFXMlViK1o3WkNndVpGNFJPRTRMbGQvVEFiMTFxak4zRlpjUWc1aU1wUVps?=
 =?utf-8?B?cmNHdWhRcThYZDFMNUpkdU1WMTd1eWpEZVZldmsxMGRPdXY3L25leW9nRGpE?=
 =?utf-8?B?eStUTElVd2k5a2hJSURsNWQxeVZkeXFaMHJrWWJ2VFR1LzdMZm9lbWEyZjJy?=
 =?utf-8?B?UHBBMDRSQW50M2NCVlVXT0trYzFsaDlXQSs0VGp3TG84NnJDOTJhSGlwWVZ5?=
 =?utf-8?B?RnhNczhWS0ZMTlhMMTdFc1YrQ29XKzlqNStqSHQySzJYeHZ3ZkpucEtFZUFD?=
 =?utf-8?B?OFVxM1U5czBxZjZDdDl1YVdKMWtneC92UXhlSEZqYi9rbXkrdkcyUkw1UStU?=
 =?utf-8?B?SnpkdTB3RFNSNGVKQnFkS2c0RVFSUXJCM0wyM09IeUhFdGFlbGwzZHpPRFpV?=
 =?utf-8?B?L1RVWktYZ2FVVk9aZzExSTBQTzJKbHZLeWhBZ2JtS0tCQjJwUmFWTjBKeHZa?=
 =?utf-8?B?c1d6MjlwazBaWDlUTGpiVmhWMXlWeENhOEQ0UndnWjdQVTlFVCtKWGZORHgw?=
 =?utf-8?B?bXdYUU9DR0J3UVErYW42TGpDN2JZR1YxeFB3UGNaSXJlUHhXTGgwRytnTERV?=
 =?utf-8?B?bkZMSWtLamFSZFBTNXpqbW5BbUxaUHpSS3RTQ1dSTTNhQ2JUMDM3enpYeEdr?=
 =?utf-8?B?U2Fmcm5zTjQxQm9sL2h5dVJlSXYrMjc3QldkMko0SStuOURYdGwxYktlZFpq?=
 =?utf-8?B?OTlxMTVvWGIrZDZPQU9BNGhrVGhSMEhoUFhJTlJEODdnUVBTOFNXVkZVTTVr?=
 =?utf-8?B?Rk9CMURFZDAyWFZBcU5hNWNhZUNvU0pmV2ZRWTJpeDdpNkdJVllxRDFmWHJH?=
 =?utf-8?B?N0VNcElraWQwbHVNLy9KUWx3Vi9JbmpvUFVhVytrNEVjTWU3L1Q5N0M3QVMw?=
 =?utf-8?B?MDNxOXpROS82bHJKeEhuUjdrMU8yUXQzcWhOVTJmeE1BSlo4eU5KclFJWWhR?=
 =?utf-8?B?QUpNM2JwT3MzaVRFTExHK3ZKSkFGRk91YlJYbm0wLzhFWGVoVE81WUF4NW44?=
 =?utf-8?B?WlhhMTFhODFaa252UlcvV0MrcjU4b3o0Njg3Wjg4MFFNVXRkZ1dDVklURkd0?=
 =?utf-8?B?SE9Vb3FLTS93RlBnN3AzYlJNdXVDNlpwS3dHQWQzVVExMjA2QXNaV0xYcTZH?=
 =?utf-8?B?eTI5a1UyY204ekErcEJUa3EwZ2lMQjNhSnBwSjhPRUpjUU5QaUxvZTVkV0Jw?=
 =?utf-8?B?OFdDdmJpZklnRVVRdDQzZ2lUVjVRNXVwcmtaUUM3ZUo3Tk5oZ2JTOUdDa0pE?=
 =?utf-8?B?Znp0cDY4OTArOUdMNTZWY1VHNk5ZN2l5S3dOclRkSVpuQ3E4Rm1vT3l4Z1B6?=
 =?utf-8?B?a3drdS81Y05vUWovR2hjbEQ0Z0Y1Myt6dWZnK1F6QjdHenIvRUxRYnJ3MUo4?=
 =?utf-8?B?d1F2YnhuWitFN3ZoUkdUbWVFMW1qSkhmTk0vQjZYcTkvRDBSZVdVYUh4aGNr?=
 =?utf-8?B?aURSVWI2UEpDdXcxMUF3VU0yZVdCaHhNVGxVQkVWM2F5L016VVl5cWZ6Qlp4?=
 =?utf-8?B?cXdTTzZrcG9VaGhsajFQNTZPQkRwd01kbXdmVm1kSG1LNi9tSlQ2MVlzVE1p?=
 =?utf-8?B?QTI1V1pDL2owQ2phMXRlUDhtU0J5Q2ZYRTNlMHNXWHRYM1NmMFJyK2ZGelp6?=
 =?utf-8?B?MGpieEJqVUhOZWFST3hqdkRJOVhlaEY3OHRqMGVhMFA3dk9PWEFQdTRMVnRE?=
 =?utf-8?B?eTMwdVpxcW8zVS9NdVkrTFlXTmlxeU43cDNVc3M0d1AyamNZWVBScEVUZnpL?=
 =?utf-8?B?Sjd6ZXJaSnAvR3d6bnJYU2F2dW10T1lxd3dMTDNJSDV1Uy9SV3l5QUNnL3hy?=
 =?utf-8?B?UEhxTS96eWV6dlh6allDcGpBd1ZmRHI0RUxZWjVUVFB6QWpvY2J0dz09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c6cfc7-7935-44a6-9937-08df2f1a3684
X-MS-Exchange-CrossTenant-AuthSource: CHBPR03MB959535.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:22:54.2834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlxaXw5wj2uSPGWsUhOjRe5QQXdu/udNFiRl1x+mgwslDG6evLngEWjAcgvaHXmfH5AvyJEv1f6osdYgZ0b7MEcZsVSbf4s2ZU1gbCwvLTU=
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 16/10/2026 12:40 pm, Chen Huei Lok wrote:
> From: Tien Fong Chee <tien.fong.chee@altera.com>
>
> Return an error immediately when an invalid DDR controller type is passed
> in, so that uninitialised local variables such as val and upd_val are
> never used.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>   drivers/ddr/altera/sdram_n5x.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
> index 858f2e76aa9..43d654341cc 100644
> --- a/drivers/ddr/altera/sdram_n5x.c
> +++ b/drivers/ddr/altera/sdram_n5x.c
> @@ -2450,6 +2450,9 @@ static int set_cal_res_to_umctl2(struct ddr_handoff *handoff,
>   
>   		upd_val = GET_LOWB_DATA(readw((uintptr_t)(handoff->phy_base +
>   					DMEM_MB_CDD_CHB_WW_0_1_OFFSET)));
> +	} else {
> +		debug("%s: Invalid DDR controller type\n", __func__);
> +		return -ENXIO;
>   	}
>   
>   	upd_val = max(val, upd_val);


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

