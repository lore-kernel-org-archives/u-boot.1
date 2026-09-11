Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E652C88E4D
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 13:18:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC01E60674;
	Fri, 11 Sep 2026 13:18:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1pxQSl06WoDD; Fri, 11 Sep 2026 13:18:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 30EF560665
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789132732;
	b=Z1+u+YUak2n6m4iyXzBfjm3cS674CdT4BGmRCWrj/0EnpmrnSvObh4oNzoVJQipIHQGh
	 sUV3/C9yOvotI+Qrt8x1EUDD6n+tILiN9RQyqRescxcsgXTbQknLV67LwPV3sf0+ueW3R
	 OcBBXQdZWSBEWBzlThT2igxI+cPAEXksyIxSqE7ZOrkAg29WzUMF4n0jMGg7i7XjymRqx
	 IOWIeztbo2dkOqPFjHBDkfAX7lD5Oy221crwh8jpJ0npUvObMqluafmccqGNRlSf2v1Iv
	 mMpPsybVnEw6Ki/ga5li7VyJ8NjDQPGbbv7Dy5CSAGt3361ZBu/6ttsDwR8SpKJTO4A==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789132732;
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
	bh=7Od2r2UDO8I1wpEDzncrNKYtqajDTtqK4kPYKJcESos=;
	b=r8FoGadW9si+vSclh69gCuQVgHjs8XvszyhjFUNeV4PtGWQUFgY5blHJRvTlDin75oMH
	 /rD2OnoV7d0Kzwlz9K5GpiNMLSdQiL4Ig8EWyVuak4m3C4fjqTn2kRSvtSNffD2x5yicZ
	 T7ZLk8EbllsgLPOu00xGwkO/8sCTUkYEQyaXPt356g4p00h1/zDlNCfCVEiiGW1KUnsPr
	 faqcycVI7u/Mkm9f1ITC0aQK3MEOaDD36Mohq5MJ2xWsbYQMCn4zhsLXx/cOvW8WMR281
	 sPEhChG8vWQJvj2aIPOgx7OQQFDZx6Ny+cIOTJnLJ/QXDL5vqoOuJCpUG63QLY1S/bg==
ARC-Authentication-Results: i=4; smtp3.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=OlEsKGgI;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=OlEsKGgI;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789132732;
	bh=7Od2r2UDO8I1wpEDzncrNKYtqajDTtqK4kPYKJcESos=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oIJ8VZb6vdTxaLvN+93xE7NDrhzE/2lgzxatJkmn82qPT276DmNQkC2LIvjeAnFxZ
	 +UkKelyPyxPnDtqNRUGlP72UV8TEE83kHLrGc1ylf3CW+p5VfZ4ryxeVbo8CPiAPa6
	 6N51v4koIFXugx61BT9DlzRx4qHGkqTAgnBcnHRIw9Fq46YrjBjXMms+79mwt2PPYk
	 8sSN4J1U+rLy+qxdA7Pi5exAcR8PgkDS9Fu8SMhN9KJhsevk0S4qE8LaBJv3S5TIzj
	 fs35EWALwObSd11sNV402zMe+6hQT15lJyL7IsPcdxZ4KzT7SBeCS5ZulI/OH2+7sG
	 NF6bosTP0NGlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30EF560665;
	Fri, 11 Sep 2026 13:18:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BB7F22E3
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:18:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AD0ED60665
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:18:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YYzqhT7C3tTM for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 13:18:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B16BE605EC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789132730;
 b=lEvQQoMaE4LQfDlbMhJA1ikWAnRyy8j4dzQybOGSIBXRsk/SsGw/6siY6eTccrvUzwsZ
 8dMjxtr+ePRBlbEq0aMXhaYgEtP9LQhRjULxPn7VRgIKy5LegOI8UYZ0n1jtZeGHLruTy
 nhpSdghRvlyr7bJrAI55D+PwkdKrHJ4c6Xv0ubTAtrQh2mgBSLAcjGKiygl/PhzB/hDMs
 Nq2exyq0q/2I1Yp8K45oKoBPI6YfQhj5WxzivNawaGJNbbVN95dhcd/P3gRkC1VivngMo
 PKjHflLxYjy2hjBr+3b0kHozWtBllvr0UU4Nb8TB4ggdZOYjtS44qwj2Onh+BliJ5Pw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789132730;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:From:Subject:To:Cc:References:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=7Od2r2UDO8I1wpEDzncrNKYtqajDTtqK4kPYKJcESos=;
 b=HcFL+LUb4ys6ge9+4apg6S6Fh4kTtCwJfeI+yW2oJvb2vlxQhX8RuemFnNTQovxntHod
 t1D5ZElkXwhaOP3MxHVEjD8OnH9pAyO72XRlbapwUGE9pMuZn25Jft/Mm1RbCmpnbTy+r
 cpXDmUh0K+A+e6vK/5N7/UsRCwXwjRhShqWevUucpvS7mqiH6szj/wisVP+9ST2BKH6A4
 bMbev4GOXK8Q87PgIdnRrAr+nu3SM+jgLAgsTHhe1uUUTVWPfF9ZJ1Nl9kuUGAjxwC01e
 tRKxCcHtiK3A2aDsFKvDUApGp+6oZnXhd5W6rA5uDZ6AegIUchyYTiQYPBkq9b9QGng==
ARC-Authentication-Results: i=3; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=OlEsKGgI; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=OlEsKGgI; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=OlEsKGgI; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=OlEsKGgI
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B16BE605EC
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:18:47 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xa+A+KGQ+noOkrXBRoJgadHQ98XzJB/US3KUN0KITCcoHFZqz2o9uh27CJgJ8psug6VHGkbW8ImLgvL9Cs436PsMCFtWKMe2ADSWt4wfWxFOGC4JvX+AVi+07l39OgB371SxJrkF57uSlMlA9j5YvQBjjeFEaIjFkC45N+WkmwSjUEob1r0iXW4qNILK2CV6DRG+go7AVUlqoxQcqMmVVrukJo3Ld16PM05QvqUKHRoUbEadNbaGGQICjMh/sS+rpfEYyDsZ5AkyE/ko1nBVPn7lEkCJI+drjGSLdSy5xxFuyTXKFcJUOGTxz585Fodu8zpPf6m5Vkee4USKsK4Hhw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Od2r2UDO8I1wpEDzncrNKYtqajDTtqK4kPYKJcESos=;
 b=pb949oUG3/aoChZf/j3V852QVjdYAh7oOqQqGumykJE8vA+kS+MAkwZSM61YuzpfX1Q4LDefN+rsSyTcUEs4Rn8Whe1UKcgAx/T0apsGDnAEHdIrqmbUhfhPlICgF1t+9JNipEiQKdzYLir4qePmSKTCxd3s++SWc09S/Q67pbtdR8zmq/CCvjrIFULhtlw/I+98rxCPFRt4p4mrvfWefGI9oGZDE6QtZMRzOBtxYSr0EA460HcAT7uLqF837xclRbFVvms2zrwC2RkcoUaQmvQ7alpyv5v4gNSmy0UzT+dztYTRdX1mUf/6bw/ml65iQYP0rCZALplq5eBuDNs6Jw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=arm.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=arm.com; dkim=pass (signature was verified) header.d=arm.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com]
 dkim=[1,1,header.d=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Od2r2UDO8I1wpEDzncrNKYtqajDTtqK4kPYKJcESos=;
 b=OlEsKGgIr/XQDAzqCcjAIvvHg+PEbcpAM+hMGlRxyWrZg1XSCFkUC6n995MRh9iFOkyK8nlIyCpJMToMGP1NRLQrOFE9DCMCmaxbq8ut89RHJlpoVpuKXGsh1u0dclJJfQTTSzu6uQFXQq3j/VMMQpCk0YfnZz+95aReHefi0yE=
Received: from MA3P292CA0056.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250:48::14)
 by GV2PR08MB388410.eurprd08.prod.outlook.com (2603:10a6:150:3b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Fri, 11 Sep
 2026 13:18:42 +0000
Received: from MAD0EPF000008B2.eurprd04.prod.outlook.com
 (2603:10a6:250:48:cafe::81) by MA3P292CA0056.outlook.office365.com
 (2603:10a6:250:48::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.8 via Frontend Transport; Fri, 11
 Sep 2026 13:18:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008B2.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 13:18:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nn9x/vhZKUwyky+MlVnopLSHOEOp3X9cVY1ZW/lOGy+PSqeyiQe01Zdn33zA0L/3DHwOk8BEGnZ0Jegw/btac4exjdlXpDFafME1dVyQMMDgMoeDOzZL6fcBRuPK1Pu+mhUERbzfzhHEMt+YqAa5TnUt5Vt+uL/lHd3V8jdqljMzgbwahb1liq256bfU1mkUTla2smCbBgFXz1zWVCsD/v6rDwJzXXyn07fDHsDcsNkXKiySmXQ5MMJEi6DowqX811qagJDCBen0kRV2fbPkGQcLPDoWYKv7HwVeJvssiNAvaQiHyDpvyATTJ5eL7mr2Lo3LLEBhJO8iPM56gQI80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Od2r2UDO8I1wpEDzncrNKYtqajDTtqK4kPYKJcESos=;
 b=kXhATB59wvSntsIEglanumlxq4Xoknp7pq+8cEWIIL6czLt+lbDSdRFhfP1W9qk1/wej0Wz67P1jyV5q35slB1etzHwirf59dI4HR1kDcDmSYLnGsLOtediBCVE/ZLTA3Y45ltqLqJHsB44yjg+GZ7kwi+UnjoVJ33qzrx+ebxgxZ/yRWEiInSSOlfo4BHAG7R5QzMeKZ3RlN2D/PzNjgtrm+Xp+Op57+TPwNapCIaeEBiGFrk56cPmnwIA18dFautn/9u/p5LkTNz/bodUHVSecdf3rrLY2iCRIF/83YgrOcRksPejPcFkDWq6Db2M6m0I0sqGmYq6iyMa6KXf11w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Od2r2UDO8I1wpEDzncrNKYtqajDTtqK4kPYKJcESos=;
 b=OlEsKGgIr/XQDAzqCcjAIvvHg+PEbcpAM+hMGlRxyWrZg1XSCFkUC6n995MRh9iFOkyK8nlIyCpJMToMGP1NRLQrOFE9DCMCmaxbq8ut89RHJlpoVpuKXGsh1u0dclJJfQTTSzu6uQFXQq3j/VMMQpCk0YfnZz+95aReHefi0yE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PA6PR08MB11584.eurprd08.prod.outlook.com
 (2603:10a6:102:524::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 13:18:08 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0406.005; Fri, 11 Sep 2026
 13:18:08 +0000
Message-ID: <7cd8cef6-81f2-4f07-8357-60b768fbf0cd@arm.com>
Date: Fri, 11 Sep 2026 15:18:07 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v2] net: net6: validate IPv6 payload and transport lengths
 on receive
To: u-boot@lists.u-boot-project.org, Esteban Alba <estebancalba@gmail.com>
Cc: trini@konsulko.com, rfried.dev@gmail.com, v.v.mitrofanov@yadro.com,
 sjg@chromium.org, nd <nd@arm.com>
References: <20260807-net6-len-validation-v1-1-edff271cbf2c@gmail.com>
 <20260821-net6-len-validation-v2-1-29bd39f946e0@gmail.com>
Content-Language: en-US
In-Reply-To: <20260821-net6-len-validation-v2-1-29bd39f946e0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::9) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PA6PR08MB11584:EE_|MAD0EPF000008B2:EE_|GV2PR08MB388410:EE_
X-MS-Office365-Filtering-Correlation-Id: d77c58be-88ce-4aed-3e4b-08df100732f7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info-Original: +0bMFiHBN1bApC1rBznBgeFYmXjleZWHfBKB5GwOUnklwEdayILF8kDkAV0sCSvyDlJyYmIv11+TzPsG023JO//eAm8k9qu8F/+ePeW/4ar6X0WrdcWXMz0C5Gab1ksDr0M9I+f40OpA9ilKYE2xNXcmC04AtbQxZ0B0cHhY49rptIaOWc1L+gjXZEmiZzHVaQqSGFrynfep4qgWNHID4rWYdsgQ24YhG+D5t5/FWCyqGXCDYuyVIZ0dJbHdbfmqcEgDv4SeUYxr6PPnL/JbB01WnowsKjaxvgtOwOXD+FYvnhez8ruFj63qChlQGHWpAEEgyzXhUnFTqA12uVXtlaIl2FQzaVaHjF0HneeF6E7B7gpi1ecqQYcCd8X8S7nB2ZHAwoCLhGtmme4gpEQYeLQInuOx/WObtSSdIJNlVF7OApwb1ovy3tDOko74Aet6ljUEsm/lFIN4aqB4DjA8S2IlL5/MwNPz/nka03teFtsV/hKxUOS9n4KAztyg8coH18WT8pi1BE7qmbH1DsGsGegGPhKOltYGJpoRjGFYxatevAwl1kVe7k+gv5/lbjSbUB2LN6B219L1D7QZeeYH1KW4YtzqwOQ6/cyU9wCJMFDN5kRs6E4nqMKQiMANCKehYiA7ZULsMd4SsVV3prKN0/ZT9Q9+5r5E3Migu3Ot+DA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: seWWBgJU6KIbBj4qqOSnsRyM2pty1mREA7Dx1smy528bNUHEaLTK7DsjbL1wYkEdMlbrBbJHcW2sj5QLxe7YJ1x0jg2x3ECZpDMsEEKlKZtSYZI7UrxOLJiE2QLZwH4frlg1RDRhUGw50psH5NjnlrOcCrWrHKQl7/ZFOYO3CSX4PbJ/AizO4KNodDVUiv7OldL5I0nEQniHl8UQuulp82wlL6r1fffOlmAck+qHXjzAvu31Ucasj4T4FuSY2ZTKXqfMwfVYeBw4WapwW+vczwCE7U5iE7MtZgp9OOs/51jJBAnXJC+SXbIwBLn/BqOCFnb4As4kNrANMF99tQxGYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB11584
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008B2.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 801146df-1967-46a8-9d37-08df10071f10
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|14060799003|82310400026|35042699022|1800799024|376014|23010399003|10067099003|4143699003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: UvLZc9FHYDhmhCq9jWSbBFwt8FlVvhW4dbfY+ph4WbT11B1+LyHXtwoQGvVW7YZux1wvjzxOiRYtxS1EmMZ80N73pNCynY54XcP9SMCp+t3ll33F+LLmyIP51VvId7KlLxEr3SoriPraSEtHfXhIWaWJeTMLfJeAW5lqugzr+wuFeMTdbvjk07RvJPDBP3Ur7ahDLkiV/JdnHtMo8wMOZyuyHfSblrtWz2B7HSQjEEOcjZprLFba58E3DVybrU3sa+dNqwtSA75Y45Y1hQZS/VZDZ7v6UWQOynbmN0beOtQLn43id1PuBDGpFJSw1QV9a4h1JkqHQ4SYkX3BIeGFfFlaXkxLQA/CJ5Nws+DLgIOUsQEKZ19Zupbi6rBws/2sY2QisaezMyV1vP5s1Pa4CLcybY76ck23QSLeQxcTvI5Zyqf/b9ZRrBZZV7oxSOHXLHD0jQmzEwJtshozxl5YbnR8jo/qci9Jjh2h9wpuOPkhRFre6H15oNL4qNDarOpO/tj7PuEe6swB0J4qKAX37KRGctbtgLRUjRFyWEOPmYAMFH0Nhd2bmRKqv1OxAN6aM+PTtFJ5I2uU238Ktf04xNuwabr+stvTHDlX9Lh7aUDsTY0Ckg35dp6xRKl3y0tL1iXIWGL1HPJa24vmgJ+u/e9VSs1T4//4PrA7StHKhPDCgIdy1Djmwzf+Lk5Bhz7DDibOI5b1Qo9cW+8moWZwdA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(14060799003)(82310400026)(35042699022)(1800799024)(376014)(23010399003)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZcS/Gdoy3/9qMDavemqOwzYPmW49xrCGQbPQ9Yl+S+W/kh9czYvioNhZgt9XnIDn6ey6MwhYWSljf0wG+/PO1pxV3mM24FWOq4liJfwsHeytgh5YNFGmx4qSpoYgONjGj2jEJMuM0MkDvzemEpR1cO7VlkB8KxeN2Qbduns3z3vtfnXuicVCHCkvhfcBUYclGkChskZ2firy0rUwr+TsxbueNk9uKqXoNKqdcU6RhYYSNcv+CrZsvaqnP/IyxjcGW0cIyLkN9rBhpfcVXmlSpQ1dBix2xrmRNWtM/2gShhVPhWU2Nf0/uMfNosY257gg5RbByCdUD0XvhyL72FoqgFzZz7uztrZFHKYofCka6RKmqHIMBqEt8ejvNCOf/Mv7GXl6aQWqO8kO/JRHZFHlWiZbCu6kR90so4HeoN+2yHck/CJ3JEX8L+aPRG0EJSTj
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 13:18:41.4168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d77c58be-88ce-4aed-3e4b-08df100732f7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008B2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB388410
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

On Fri, 21 Aug 2026 02:07:43 -0500, Esteban Alba wrote:
> net_ip6_handler() checks the received length only against IP6_HDR_SIZE and
> then uses length fields from the packet without checking them. The checksum
> is computed over payload_len, but the UDP handler length comes from
> udp_len. A sender can keep payload_len correct so the checksum still
> validates and set udp_len larger than the frame. A handler that trusts that
> length then reads or writes past the receive buffer. The DHCPv6 client
> copies the declared number of bytes and can be made to write past the
> packet buffer from a single link-local ADVERTISE.
> 
> [...]

Applied to u-boot-net branch for-main, thanks!

[1/1] net: net6: validate IPv6 payload and transport lengths on receive
      commit: 80215cdacd2acfe92152344e5269461446aa80ff

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>

